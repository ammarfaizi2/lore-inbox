Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280867AbRKGRgx>; Wed, 7 Nov 2001 12:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280869AbRKGRgp>; Wed, 7 Nov 2001 12:36:45 -0500
Received: from boco.fee.vutbr.cz ([147.229.9.11]:33034 "EHLO boco.fee.vutbr.cz")
	by vger.kernel.org with ESMTP id <S280867AbRKGRgg>;
	Wed, 7 Nov 2001 12:36:36 -0500
From: Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>
Date: Wed, 7 Nov 2001 18:36:33 +0100 (CET)
X-processed: pine.send
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Error in ARM configuration (2.4.13) 
Message-ID: <Pine.BSF.4.40.0111071806410.1128-100000@fest.stud.fee.vutbr.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have found one strange line in arch/arm/config.in:

<PRE>
if [ "$CONFIG_ARCH_CLPS711X" = "y" ]; then
-->  source drivers/ssi/Config.in <--
fi
</PRE>

There is no directory named "ssi" anywhere. So is it misstypo or
should it be removed. Really, the first aid is to comment it out.

Tried with 2.4.13, but in 2.4.14 it looks like it's the same.

Should someone correct this?

In the list archive, there is something about this, it was for 2.4.9
kernel. I know there should be arch specific patches applied, but why to
have errors like this in vanilla kernel? (specially when correction is so
simple)

<PREV>
On Mon, 3 Sep 2001 05:07:37 +0200,
Jean-Luc Leger <reiga@dspnet.fr.eu.org> wrote:
>Due to inexistant config.in files, make xconfig fail for the following architectures :
>* arm
</PRE>

Thanks.

--

	Tomas Kasparek (sioux, xkaspa06)
 	 Tomas.Kasparek@seznam.cz
	 Linux@dcse.fee.vutbr.cz
	student UIVT FEI VUT Brno

