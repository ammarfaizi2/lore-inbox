Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275387AbRJBPqD>; Tue, 2 Oct 2001 11:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273709AbRJBPpy>; Tue, 2 Oct 2001 11:45:54 -0400
Received: from gap.cco.caltech.edu ([131.215.139.43]:5825 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S275389AbRJBPpj>; Tue, 2 Oct 2001 11:45:39 -0400
Subject: Re: your mail
To: dinesh_gandhewar@rediffmail.com
Date: Tue, 2 Oct 2001 16:30:05 +0100 (BST)
Cc: mlist-linux-kernel@nntp-server.caltech.edu
In-Reply-To: <20011002152945.15180.qmail@mailweb16.rediffmail.com> from "Dinesh  Gandhewar" at Oct 02, 2001 03:29:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15oRUj-000512-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have written a linux kernel module. The linux version is 2.2.14. 
> In this module I have declared an array of size 2048. If I use this array, the execution of this module function causes kernel to reboot. If I kmalloc() this array then execution of this module function doesnot cause any problem.
> Can you explain this behaviour?

Yes
--
Alan

[Oh wait you want to know why...]

Either

1.	You are using it for DMA
2.	You are putting it on the stack and causing a stack overflow

