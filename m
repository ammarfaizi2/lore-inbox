Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbUJaMmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbUJaMmu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 07:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbUJaMmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 07:42:50 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:33238 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261608AbUJaMmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 07:42:42 -0500
Message-ID: <4184DDA8.3040802@ens-lyon.fr>
Date: Sun, 31 Oct 2004 13:42:16 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 breaks NVidia module, cannot start X.
References: <Pine.LNX.4.53.0410311254360.2766@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0410311254360.2766@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wow, I'm wondering. The kernel-of-the-day from SUSE (20040929, 20041023
> and 20041028) (2.6.8 + 2.6.9-rc2 IIRC) do not even have unsigned int
> __VMALLOC_RESERVE in arch/i386/mm/init.c.
> 
> More surprisingly, there is not any VMALLOC thing in the NV sources:
> 
> 12:56 io:../src/nv # pwd
> /usr/src/NV/NVIDIA-Linux-x86-1.0-4496-pkg0/usr/src/nv
> 12:56 io:../src/nv # grep VMALLOC_RES *
> 12:56 io:../src/nv # cd /usr/src/NV6/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/
> 12:56 io:../src/nv # grep VMALLOC_RES *
> 12:56 io:../src/nv #

IIRC, they are using MAXMEM which is defined to 
(-__PAGE_OFFSET-__VMALLOC_RESERVE) in asm-i386/page.h

Brice
================================================
Ph.D Student
Laboratoire de l'Informatique et du Parallélisme
CNRS-ENS Lyon-INRIA-UCB Lyon
France
