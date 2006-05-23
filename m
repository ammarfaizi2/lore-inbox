Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWEWSLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWEWSLw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWEWSLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:11:52 -0400
Received: from fep32-0.kolumbus.fi ([193.229.0.63]:58960 "EHLO
	fep32-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1751131AbWEWSLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:11:52 -0400
Date: Tue, 23 May 2006 21:11:50 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: James Lamanna <jlamanna@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Sense data errors trying to read from tape - 2.6.14-gentoo-r5
In-Reply-To: <aa4c40ff0605230822r34230211o9fa276234545dd59@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0605232108300.5791@kai.makisara.local>
References: <aa4c40ff0605230822r34230211o9fa276234545dd59@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2006, James Lamanna wrote:

> On 5/23/06, James Lamanna <jlamanna@gmail.com> wrote:
> > Was trying to do an 'amrestore /dev/nst0' when I received the following
> > OOPS:
> >
> 
> [SNIP]
> 
> > I've also had problems restoring large XFS partitions off of tape
> > (amrestore returns with input/output errors), but I'm not sure whether
> > that is kernel or userspace related (no errors in dmesg or anything).
> > In that case, amrestore did not have any problems restoring TAR-ed
> > filesystems from tape (that was with 2.6.14-gentoo-r5).
> >
> 
> [SNIP]
> 
> As a follow-up to the above on 2.6.14-gentoo-r5, while trying to
> restore an XFS partition off of the tape (amrestore/dd doesn't oops on
> this kernel) my dmesg fills with the following:
> 
> st0: Error with sense data: <6>st0: Current: sense key=0xb
>    ASC=0x4b ASCQ=0x0
> 
The sense key is "Aborted Command". The ASC and ASCQ fields translate to 
"Data phase error".

My first guess is that there are SCSI bus problems (cabling, termination, 
etc.).

-- 
Kai
