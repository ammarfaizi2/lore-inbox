Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274416AbRITK4v>; Thu, 20 Sep 2001 06:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274417AbRITK4l>; Thu, 20 Sep 2001 06:56:41 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:37824 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S274416AbRITK42>;
	Thu, 20 Sep 2001 06:56:28 -0400
Date: Thu, 20 Sep 2001 12:56:24 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200109201056.MAA17427@harpo.it.uu.se>
To: davidchow@rcn.com.hk, linux-kernel@vger.kernel.org
Subject: Re: VIA Cyrix C3/MIII CPU
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001 14:34:55 +0800, David Chow wrote:

>I am testing my board using the Cyrix C3 733 CPU. After installing the
>newly compiled kernel 2.4.7 , after the message "freeing unsused memory"
>and hangs... anyone has this before? I am using the new VIA 694T chipset
>. Or anyone test the Cyrix C3 CPU? Thanks

Sounds like a configuration error. Make sure you configured your
kernel for a C3 (CONFIG_MCYRIXIII) or a P5MMX -- NOT a regular 686.
Same goes for user-space libraries etc: they MUST NOT be compiled
for a 686-class machine.

(VIA C3 pretends to be a 686 but does not implement the CMOV
conditional move instruction. In theory this is ok because CMOV
is officially optional, but gcc uses CMOV when compiling for
686 since every other known 686 has it.)

/Mikael
