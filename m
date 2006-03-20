Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbWCTVqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbWCTVqe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWCTVqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:46:34 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:20382 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964989AbWCTVqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:46:33 -0500
Date: Mon, 20 Mar 2006 22:46:31 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dirk Reiners <dreiners@iastate.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
In-Reply-To: <1142890822.5007.18.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0603202244370.11933@yvahk01.tjqt.qr>
References: <1142890822.5007.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>	Hi everybody,
>
>while trying to back up a couple Linux directories to a FAT disk I ran
>into a weird situation: I can't create a file called aux.h on the FAT
>system! 
>
On DOS et al, there are a number of special filenames, such as

	com1:
	com2: (and so on)
	lpt1:
	lpt2: (and so on)
	con:
	aux
	nul

(Try `dir >nul`, it's equivalent to unix's `ls -l >/dev/null` --
aux is the auxiliary port, whatever that is)

It seems only fair to me to not allow creating these files under Linux 
either, to avoid problems when booting back to Dos/Windows.


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
