Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTDEMKc (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 07:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbTDEMKc (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 07:10:32 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:10256
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262174AbTDEMKb (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 07:10:31 -0500
Date: Sat, 5 Apr 2003 03:30:35 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Fixes for ide-disk.c
In-Reply-To: <200304050533_MC3-1-331B-7B23@compuserve.com>
Message-ID: <Pine.LNX.4.10.10304050328350.29290-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If the drive is compliant it will issue an abort if not supported.
Otherwise one should check the identify page; however, there are several
cases where the bits are improperly set.  Another double edge sword to
make the driver more interesting.

Cheers,

On Sat, 5 Apr 2003, Chuck Ebbert wrote:

> 
> John Bradford wrote:
> 
> 
> >Did we ever establish what the best way to ensure
> >that the write cache is flushed, is?  An explicit
> >cache flush and spin down are both necessary, but
> >I had problems with drives spinning back up when
> >we did the spindown first.
> 
> 
> Disks that don't support flush should be sent an IDLE command, IIRC.
> 
> 
> 
> --
>  Chuck
>  I am not a number!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

