Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262673AbVCaAwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVCaAwm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 19:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbVCaAwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 19:52:41 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:7379 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262675AbVCaAvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 19:51:12 -0500
Subject: Re: 2.6.11, USB: High latency?
From: Lee Revell <rlrevell@joe-job.com>
To: David Brownell <david-b@pacbell.net>
Cc: kus Kusche Klaus <kus@keba.com>, stern@rowland.harvard.edu,
       linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200503301457.35464.david-b@pacbell.net>
References: <200503301457.35464.david-b@pacbell.net>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 19:51:05 -0500
Message-Id: <1112230265.19975.21.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc list restored]

On Wed, 2005-03-30 at 14:57 -0800, David Brownell wrote:
> Quoth rlevell@joe-job.com:
> > I think this is connected to a problem people have been reporting on the
> > Linux audio lists.  With some USB chipsets, USB audio interfaces just
> > don't work.  There are dropouts even at very high latencies.  
> 
> Well, I'd not yet expect USB audio to work over EHCI quite yet,
> though one of the patches Greg just posted should help some of
> the issues with full speed iso through USB 2.0 hubs.  (At least
> for OUT transfers as to speakers.)
> 

This is the exact configuration of one of the users who reported the
problem on LAU.  Got a pointer to the patch?  And what's the issue with
IN transfers?

> You might consider reporting such issues on the Linux-USB list.
> It's been ages since anyone reported such a bug with the OHCI
> or UHCI drivers ... probably why folk have assumed there are
> no problems there.
> 

OK, good to know.

> 
> Something to consider specifically with audio.  That uses the
> isochronous transfer mode, reserving USB bandwidth.  But I've
> certainly seen systems with PCI busses that are severely clogged,
> so that the USB controllers have a hard time accessing main
> memory.  Even a perfectly functional USB stack will have a hard
> time with such hardware!

Unlikely because it works under Windows.  We're not all that far behind
however; USB audio on that OS did not really work until XP SP1.  Also,
if that were a widespread problem we would be seeing problems with PCI
devices too.

Also please fix the threading in your email client.

Lee

