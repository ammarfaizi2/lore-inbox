Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267276AbUHIUmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267276AbUHIUmE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUHIUlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:41:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:38080 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267243AbUHIUi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:38:28 -0400
Date: Mon, 9 Aug 2004 13:27:23 -0700
From: Greg KH <greg@kroah.com>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, arjanv@redhat.com, dwmw2@infradead.org,
       jmorris@redhat.com, chrisw@osdl.org, sfrench@samba.org, mike@halcrow.us,
       trond.myklebust@fys.uio.no, mrmacman_g4@mac.com
Subject: Re: [PATCH] implement in-kernel keys & keyring management
Message-ID: <20040809202723.GA31794@kroah.com>
References: <20040808025229.GA15737@kroah.com> <6453.1091838705@redhat.com> <20040807011758.62831dbf.akpm@osdl.org> <15760.1092043400@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15760.1092043400@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 10:23:20AM +0100, David Howells wrote:
> 
> Greg KH <greg@kroah.com> wrote:
> > I think that if the /proc interface was moved over to sysfs (which is
> > where it should be), a number of these syscalls would go away.
> 
> Well, I could move these two files into /sysfs. But just doing that wouldn't
> get rid of any of the system calls. To move these files into sysfs, should I
> create a "keys" subsystem?

Yes.  But then you would have to split the info in these files up into
many different files, as it's "one value per file" for sysfs files :)

> Can you elaborate as to what you envision? I wonder if you'd thinking that I
> should make every key a kobject and fan-out them out in a directory in sysfs
> somewhere. I really don't want to do that, though... kobject seems to add
> quite a large overhead that I'd rather avoid (a directory in sysfs for
> instance).

James has gone into the detail of a filesystem type interface for this
code much better than I can envision.

thanks,

greg k-h
