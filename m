Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbVKUQcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVKUQcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVKUQcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:32:31 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:35494 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S932380AbVKUQca convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:32:30 -0500
Date: Mon, 21 Nov 2005 17:33:48 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
cc: Daniel =?iso-8859-1?q?Marjam=E4ki?= <daniel.marjamaki@comhem.se>,
       linux-kernel@vger.kernel.org, 7eggert@gmx.de, nish.aravamudan@gmail.com
Subject: Re: I made a patch and would like feedback/testers (drivers/cdrom/aztcd.c)
In-Reply-To: <200511211919.11429.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.58.0511211729510.2082@be1.lrz>
References: <5aZsv-3CJ-17@gated-at.bofh.it> <E1EdwGs-0000qv-NL@be1.lrz>
 <438180C0.2030503@comhem.se> <200511211919.11429.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Con Kolivas wrote:
> On Mon, 21 Nov 2005 19:09, Daniel Marjamäki wrote:

> > The way I do it:
> > All systems will give me a delay for at least a few ms.
> > I get the shortest timeout possible on each computer.
> 
> Convention in the kernel would be 
> 	aztTimeOut =  HZ / 100 ? : 1;
> to be at least one tick (works for HZ even below 100) and is at least 10ms.

You have to add one to the timeout, since you might be just before the end 
of the timeslice when the delay starts. aztTimeOut = (HZ / 100 ? : 1) + 1;

-- 
Top 100 things you don't want the sysadmin to say:
11. Can you get VMS for this Sparc thingy?
