Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276249AbRKMQpy>; Tue, 13 Nov 2001 11:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276364AbRKMQps>; Tue, 13 Nov 2001 11:45:48 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:49675 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S276249AbRKMQon>;
	Tue, 13 Nov 2001 11:44:43 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rajiv Malik <rmalik@noida.hcltech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fdutils. 
In-Reply-To: Your message of "Tue, 13 Nov 2001 14:41:40 +0530."
             <E04CF3F88ACBD5119EFE00508BBB21216C828E@exch-01.noida.hcltech.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Nov 2001 03:44:30 +1100
Message-ID: <16521.1005669870@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001 14:41:40 +0530, 
Rajiv Malik <rmalik@noida.hcltech.com> wrote:
>does linux floppy driver support super drives (LS-120/LS-240)

LS-120 definitely, it is required for IA64.  With devfs, they appear
under /dev/ide/...  Format without a partition table using

  mkfs.msdos -I /dev/ide/....

You can create partition tables on LS-120 but some code expects
unpartitioned floppies, even big ones.

