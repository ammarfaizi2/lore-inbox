Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbUKJXX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUKJXX3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 18:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbUKJXX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 18:23:29 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:26322 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262065AbUKJXXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 18:23:23 -0500
Subject: Re: mmap vs. O_DIRECT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <cmtsoo$j55$1@gatekeeper.tmr.com>
References: <cmtsoo$j55$1@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100125196.20792.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 10 Nov 2004 22:19:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-11-10 at 00:05, Bill Davidsen wrote:
> I have an application which does a lot of mmap to process its data. The 
> huge waitio time makes me think that mmap isn't doing direct i/o even 
> when things are alligned.

Make sure you are using MAP_SHARED in such cases so that the object you
have is the page cache object, also remember to use madvise

