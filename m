Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311121AbSDQRcb>; Wed, 17 Apr 2002 13:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSDQRca>; Wed, 17 Apr 2002 13:32:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33102 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S311121AbSDQRc0>; Wed, 17 Apr 2002 13:32:26 -0400
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW ARCHITECTURE FOR 2.5.8] support for NCR voyager (3/4/5xxx series)
In-Reply-To: <200204161601.g3GG1nP03345@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Apr 2002 11:25:14 -0600
Message-ID: <m1wuv6fdad.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> This patch adds SMP (and UP) support for voyager which is an (up to 32 way) 
> SMP microchannel non-PC architecture.
> 
> The patch is in two parts:  The i386 sub-architecture split is 
> separated from the addition of the voyager components
> 
> http://www.hansenpartnership.com/voyager/files/arch-split-2.5.8.diff (269k)
> http://www.hansenpartnership.com/voyager/files/voyager-2.5.8.diff (150k)
> 
> (The split diff is pretty huge because it's actually moving files about).  You 
> must apply the split diff before applying the voyager one.
> 
> These two patches are also available as separate bitkeeper trees:
> 
> http://linux-voyager.bkbits.net/voyager-2.5
> http://linux-voyager.bkbits.net/arch-split-2.5

Currently you place the voyager information in the APM table,  which is problematic
for the goal of being able to have a kernel that will support everything,
and it is a little confusing.  There is still plenty of room for the voyager table,
elsewhere so I don't think that is needed.

Please check out include/asm-i386/boot_param.h for an enumeration of where
we actually put the variables.  Since it hasn't made it into the kernel
yet either get out of the linux-kernel mailing list or at:
ftp://download.lnxi.com/pub/src/linux-kernel-patches/boot/linux-2.5.8.boot.diff

Eric
