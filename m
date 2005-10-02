Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVJBUwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVJBUwZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 16:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbVJBUwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 16:52:25 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:55057 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S932068AbVJBUwY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 16:52:24 -0400
From: Felix Oxley <lkml@oxley.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt1
Date: Sun, 2 Oct 2005 21:51:49 +0100
User-Agent: KMail/1.8.2
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu> <20051002151817.GA7228@elte.hu>
In-Reply-To: <20051002151817.GA7228@elte.hu>
Cc: Ingo Molnar <mingo@elte.hu>, ralf@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510022151.51133.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a compile error in drivers/net/hamradio/mkiss.c

	CC [M]  drivers/net/hamradio/mkiss.o
	drivers/net/hamradio/mkiss.c:625: error: 
	RW_LOCK_UNLOCKED’ undeclared here (not in a function)

Due to the fact that

	RW_LOCK_UNLOCKED 

has not been converted to the form

	RW_LOCK_UNLOCKED(name.lock)

by the RT patch.

But I don't actually need this module anyway. :-)
regards,
Felix
