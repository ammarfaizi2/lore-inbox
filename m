Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbVIFFGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVIFFGE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 01:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVIFFGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 01:06:03 -0400
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:16512 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932400AbVIFFGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 01:06:02 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Daniel Phillips <phillips@istop.com>
Subject: Re: GFS, what's remainingh
Date: Tue, 6 Sep 2005 00:05:58 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>,
       Andi Kleen <ak@suse.de>, linux clustering <linux-cluster@redhat.com>,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509052307.27417.dtor_core@ameritech.net> <200509060058.44934.phillips@istop.com>
In-Reply-To: <200509060058.44934.phillips@istop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509060005.59578.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 September 2005 23:58, Daniel Phillips wrote:
> On Tuesday 06 September 2005 00:07, Dmitry Torokhov wrote:
> > On Monday 05 September 2005 23:02, Daniel Phillips wrote:
> > > By the way, you said "alpha server" not "alpha servers", was that just a
> > > slip? Because if you don't have a cluster then why are you using a dlm?
> >
> > No, it is not a slip. The application is running on just one node, so we
> > do not really use "distributed" part. However we make heavy use of the
> > rest of lock manager features, especially lock value blocks.
> 
> Urk, so you imprinted on the clunkiest, most pathetically limited dlm feature 
> without even having the excuse you were forced to use it.  Why don't you just 
> have a daemon that sends your values over a socket?  That should be all of a 
> day's coding.
>

Umm, because when most of the code was written TCP and the rest was the
clunkiest code out there? Plus, having a daemon introduces problems with
cleanup (say process dies for one reason or another) whereas having it in
OS takes care of that.
 
> Anyway, thanks for sticking your head up, and sorry if it sounds aggressive. 
> But you nicely supported my claim that most who think they should be using a 
> dlm, really shouldn't.

Heh, do you think it is a bit premature to dismiss something even without
ever seeing the code?

-- 
Dmitry
