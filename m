Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVBORKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVBORKZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 12:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVBORIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 12:08:06 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:48768 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261795AbVBORFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 12:05:30 -0500
Subject: Re: IO port conflict between timer & watchdog on PCISA-C800EV
	board ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Charles-Edouard Ruault <ce@idtect.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <420734DC.4020900@idtect.com>
References: <420734DC.4020900@idtect.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1108487045.4618.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 15 Feb 2005 17:04:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-02-07 at 09:29, Charles-Edouard Ruault wrote:
> - Why is the generic timer using this address ? isn't it reserving a too 
> wide portion of IO ports ? Should it be modified for this board ?

It just reserved the entire chip space since way back when.

> -  If there's a good reason for the timer to request this address, is  
> there a clean way to share it with the timer ?

Submit a small patch to Linus/Andrew to make the generic code only
reserve the ports it should. It's just a historical oversight

