Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271911AbRIMR1J>; Thu, 13 Sep 2001 13:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271905AbRIMR07>; Thu, 13 Sep 2001 13:26:59 -0400
Received: from maynard.mail.mindspring.net ([207.69.200.243]:42245 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271911AbRIMR0s>; Thu, 13 Sep 2001 13:26:48 -0400
Subject: Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: Arjan Filius <iafilius@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109102323450.24212-100000@sjoerd.sjoerdnet>
In-Reply-To: <Pine.LNX.4.33.0109102323450.24212-100000@sjoerd.sjoerdnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.12.07.08 (Preview Release)
Date: 13 Sep 2001 13:27:06 -0400
Message-Id: <1000402027.23162.45.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-09-10 at 17:29, Arjan Filius wrote:
> Yes I am using reiserfs (for "ages"). better said, reiser on LVM.
> 
> Small discription of my system and used setup:
> scsi-disk,scsi-cdrom,ide-disk,ide-scsi,ext2,reiser, iptables, ipv6,
> acenic-Gbit-ethernet, ramdisk, highmem (1.5GB-ram), Athlon 1.1GHz, Asus
> a7v MB (via).

Hi Arjan,

first, highmem is fixed and the original patch you have from me is good.
second, Daniel Phillips gave me some feedback into how to figure out the
VM error.  I am working on it, although just the VM potential --
ReiserFS may be another problem.

third, you may be experiencing problems with a kernel optimized for
Athlon.  this may or may not be related to the current issues with an
Athlon-optimized kernel.  Basically, functions in arch/i386/lib/mmx.c
seem to need some locking to prevent preemption.  I have a basic patch
and we are working on a final one.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

