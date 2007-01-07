Return-Path: <linux-kernel-owner+w=401wt.eu-S932325AbXAGCND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbXAGCND (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 21:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbXAGCND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 21:13:03 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:25572 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932325AbXAGCNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 21:13:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J2oQrHIxetNItDHpzTS2wVdBknnpiZFGhOjEa+s+FchuM4JTHCBS3FDA17+kElznUjvFpiEyYyGrxBzS9P0azaTAbkV/8Gj8AEDBZjbg6q4MOvmqC73PZUCr7qRG7heFbC74BSTKA+ZzzcnkV5LbehzIhvxxDEv/Kbq19LnYOlM=
Message-ID: <58cb370e0701061812s49c4b1f5p5c5e99e5eea3bb89@mail.gmail.com>
Date: Sun, 7 Jan 2007 03:12:59 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Conke Hu" <conke.hu@gmail.com>
Subject: Re: [PATCH 1/3] atiixp.c: remove unused code
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Greg KH" <greg@kroah.com>
In-Reply-To: <5767b9100701060411h13324086uf6552a5166641534@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5767b9100701060411h13324086uf6552a5166641534@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/07, Conke Hu <conke.hu@gmail.com> wrote:
> A previous patch to atiixp.c was removed but some code has not been

This one?

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=ab17443a3df35abe4b7529e83511a591aa7384f3

Doesn't it break existing setups without giving ANY warning?

theoretical (I don't have hardware in question) scenario:
- user uses atiixp and has modular libata/ahci (or no libata/ahci et all)
- user does kernel upgrade
- boot fails
- ...

If this is true please add something like

printk(KERN_WARNING "PCI: setting SB600 SATA to AHCI mode"
" (please use ahci driver instead of atiixp)\n");

to quirk_sb600_sata() so people will at least know what is wrong...

> cleaned. Now we remove these code sine they are no use any longer.

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

[ but the patch is line wrapped and unfortunately doesn't apply ]

PS: please always cc: linux-ide@vger.kernel.org on PATA/SATA patches

Thanks,
Bart
