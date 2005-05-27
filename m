Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVE0LMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVE0LMY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 07:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbVE0LMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 07:12:24 -0400
Received: from animx.eu.org ([216.98.75.249]:53672 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262432AbVE0LMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 07:12:18 -0400
Date: Fri, 27 May 2005 07:09:15 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <20050527110915.GA12099@animx.eu.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org
References: <4847F-8q-23@gated-at.bofh.it> <E1Db3zm-0004vF-9j@be1.7eggert.dyndns.org> <4295005F.nail2KW319F89@burner> <8E909B69-1F19-4520-B162-B811E288B647@mac.com> <4296EADA.nail3L111R0J3@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4296EADA.nail3L111R0J3@burner>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> Try to start with reading the cdrecord manual page. Your question
> is answered in there.....but if you issue a command that is only
> halfway correct you will never be able to get the full set of features from 
> cdrtools. Using UNIX device names for SCSI devices is highly nonportable 
> and for this reason not supported by a portable program like cdrecord.
> 
> Cdrecord includes the needed features to do what you like, but do not
> asume that you will be able to force me to make nonportable and Linux
> specific interfaces a gauge for the design of a portable program.
> If you read the cdrecord man page, you know that you could
> happily call cdrecord dev=green_burner.....

Portable programs have specifics to each OS that it can be compiled on.  Why
do you think some portatble programs use automake?  Not ever OS defines
variables the same way or uses them the same way as others.

You are going to have to realize that accessing devices directly under
different OSes will require different code.  I've read all the stuff you've
posted and it is apparent that you want all OSes to use the scsi scheme.

I don't use cdrecord much anymore since 1) I have a DVDRW and 2) I burn
DVDs mostly.  It happily uses /dev/<whatever> instead of compilaining that
it's unintentional.

As far as I can see, you can use scsi ioctls on regular devices so why do
you really need to use the 3 numbers?  To find the right /dev/sg and use it? 
Doesn't make sense.  I looked at the eject program one day.  The IOCTL used
to eject a cdrom is different than solaris.  Gee, I guess eject is not
portable.  You should probably write a library that deals specifically with
each OS.  I don't ever see something like this being portable.  Especially
between a Unix environment and a Windows environment.

P.S. This is the first and will be the last time I post on this thread.  I'm
not trying to flame anyone, this is mostly an enduser observation.  The
native OS device usage should be used instead of something supposedly
portable.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
