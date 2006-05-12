Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWELVrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWELVrI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 17:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWELVrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 17:47:08 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:64815 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932171AbWELVrH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 17:47:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f54OwnX0wIjPs0qLoqAWRc89EPvz7/sUun0kqMhh9wkwbR4VE4ipscBxzYnsU8Sw5x3YmQr3oXamSdAJ0vo4SdB2Z3EuvdbqSTdmYL+/duzvTp9GUnqEN1LDF4+EOeGudBfg7FQIEh/pKlzkrN17UET+nT1DW5Lln2tPP4hgp0I=
Message-ID: <c0c067900605121447k35bacaffwc3feca071385ca6a@mail.gmail.com>
Date: Fri, 12 May 2006 17:47:06 -0400
From: "Dan Merillat" <harik.attar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [dm-crypt] dm-crypt is broken and causes massive data corruption
In-Reply-To: <e3vkeh$12h$1@news.cistron.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <445F7DCC.2000508@igd.fraunhofer.de>
	 <20060509190457.GL16180@agk.surrey.redhat.com>
	 <e3vkeh$12h$1@news.cistron.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/06, Paul Slootman <paul+nospam@wurtel.net> wrote:

> A data point:
>
> I'm running my /home on reiserfs3 over dm-crypt over lvm over raid5 for
> at least a year now, without any problems. Currently running 2.6.13.4
> (that's my "stable" work system...).

Datapoint:

Linux fileserver 2.6.15.6 #1 PREEMPT Wed Mar 8 20:26:55 EST 2006
x86_64 GNU/Linux
CONFIG_MD_RAID5=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_SNAPSHOT=y
CONFIG_CRYPTO_AES_X86_64=y

encrypted logical volume on a raid-5 MD on 4 SATA drives, mounted reiser3.

aes-cbc-plain

It's worked through multiple kernels, and moving from 32 to 64bits.
2.6.11 (64-bit) 2.6.10 (64bit) 2.6.8 (32bit) is the kernel history I
have so far.  I'm not sure when I switched from cryptoloop to dm-crypt
though, at least before may '05.

I'm not running dm-crypt directly on MD, though, the stack is
SATA->MD->DM->DM-crypt->reiser3.   That may be the difference.

I've got plenty of free space, I could make a ~75gb encrypted
partition and run any sort
of write pattern test/filesystem you want me to try.
