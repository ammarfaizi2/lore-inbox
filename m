Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbUJaMCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbUJaMCF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 07:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbUJaL7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 06:59:11 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:35003 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261596AbUJaL6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 06:58:42 -0500
Date: Sun, 31 Oct 2004 12:58:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 breaks NVidia module, cannot start X.
Message-ID: <Pine.LNX.4.53.0410311254360.2766@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 19 Oct 2004, Jesse Stockall wrote:
> On Tue, 2004-10-19 at 10:42, Justin Piszcz wrote:
>> nvidia: Unknown symbol __VMALLOC_RESERVE
>> nvidia: Unknown symbol __VMALLOC_RESERVE
>
> Try
> http://ck.kolivas.org/patches/2.6/2.6.9/2.6.9-ck1/patches/nvidia_compat.diff
> Jesse

Wow, I'm wondering. The kernel-of-the-day from SUSE (20040929, 20041023
and 20041028) (2.6.8 + 2.6.9-rc2 IIRC) do not even have unsigned int
__VMALLOC_RESERVE in arch/i386/mm/init.c.

More surprisingly, there is not any VMALLOC thing in the NV sources:

12:56 io:../src/nv # pwd
/usr/src/NV/NVIDIA-Linux-x86-1.0-4496-pkg0/usr/src/nv
12:56 io:../src/nv # grep VMALLOC_RES *
12:56 io:../src/nv # cd /usr/src/NV6/NVIDIA-Linux-x86-1.0-6111-pkg1/usr/src/nv/
12:56 io:../src/nv # grep VMALLOC_RES *
12:56 io:../src/nv #

So it's not in the 4496 (which I use, due to speed problems with 5xxx and
6xxx in the past) and neither in the 6111.

I'm puzzled, comments welcome.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
