Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287337AbSBCQFE>; Sun, 3 Feb 2002 11:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287344AbSBCQEz>; Sun, 3 Feb 2002 11:04:55 -0500
Received: from [199.203.178.211] ([199.203.178.211]:56326 "EHLO
	exchange.store-age.com") by vger.kernel.org with ESMTP
	id <S287337AbSBCQEk>; Sun, 3 Feb 2002 11:04:40 -0500
Message-ID: <BDE817654148D51189AC00306E063AAE054619@exchange.store-age.com>
From: Alexander Sandler <ASandler@store-age.com>
To: "Linux Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: 2.4.17: Bug?
Date: Sun, 3 Feb 2002 18:04:10 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="x-user-defined"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I found something that looks like a bug.

The configuration is the following:
Dual CPU machine with Linux RedHat 7.1 running kernel 2.4.17 
(official), connected to SAN with two FC-HBAs (QLogic 2200).

Bug appears when I am starting two processes, first doing I/O 
to first LUN through first HBA and second doing I/O to second 
LUN through second HBA. When I am disconnecting first HBA 
from the SAN, machine getting into four minute SCSI error 
recovery and then first process exits with I/O error as it 
should, while second process getting stacked and never 
returns (this is the problem - it should continue doing I/O 
like nothing happend).

This problem appearing on SMP kernel. On UP kernel, 
everything works fine.
I found this while I was working on volume manager driver. 
This driver should be able to do fail over to another HBA (if 
available) in case of error.

I have all required hardware and software to work out this 
problem so I'll be glad to give a hand to who ever can 
(should?) or/and will start working on this.

Alexandr Sandler.
