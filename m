Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275756AbRJFWIf>; Sat, 6 Oct 2001 18:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275754AbRJFWIZ>; Sat, 6 Oct 2001 18:08:25 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37393 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275752AbRJFWIS>; Sat, 6 Oct 2001 18:08:18 -0400
Subject: Re: VFS: brelse: Trying to free free buffer
To: $}lkml.jrh{$@daria.co.uk (Jonathan R. Hudson $}lkml.jrh{$@daria.co.uk
	(Jonathan R. Hudson))
Date: Sat, 6 Oct 2001 23:14:10 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41a3.3bbf7f68.48052@trespassersw.daria.co.uk> from "$}lkml.jrh{$@daria.co.uk (Jonathan R. Hudson) " at Oct 06, 2001 10:02:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pzhy-0002Tw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In the last week, on a couple of machines running -ac{3,4,5,7},
> reiserfs, I've noticed a number of 
> kernel: VFS: brelse: Trying to free free buffer
> 
> in the syslog. Should I be concerned ? As far as I can see, there is
> no pattern.

There were a few reiserfs changes impacting how the buffer counting is done.
This sounds like a bug crept into that somewhere
