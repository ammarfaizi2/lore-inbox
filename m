Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263194AbTDLHyD (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 03:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbTDLHyD (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 03:54:03 -0400
Received: from granite.he.net ([216.218.226.66]:16140 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263190AbTDLHyB (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 03:54:01 -0400
Date: Sat, 12 Apr 2003 01:07:21 -0700
From: Greg KH <greg@kroah.com>
To: Havoc Pennington <hp@redhat.com>
Cc: "Kevin P. Fleming" <kpfleming@cox.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030412080721.GA2768@kroah.com>
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <20030411190717.GH1821@kroah.com> <20030411152920.C17638@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411152920.C17638@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 03:29:20PM -0400, Havoc Pennington wrote:
> On Fri, Apr 11, 2003 at 12:07:17PM -0700, Greg KH wrote: 
> > Problem is I don't think we can use D-BUS messages during early boot,
> > before init is called, so we still have to be able to handle startup
> > issues.  But hopefully the D-BUS code can be small enough to possibly be
> > used in this manner, I haven't checked that out yet.
> 
> I'm not sure what the threshold for small enough is, but I'll give you
> an analysis of D-BUS size.

<nice summary snipped>

Thanks for the information.  Hm, that seems a bit big for what I want to do,
but might be workable.

Oh, and to compare sizes, with udev linked against klibc (static link)
it comes out to a whopping big 6004 bytes:
$ size udev
   text    data     bss     dec     hex filename
   5572       4     392    5968    1750 udev

thanks,

greg k-h
