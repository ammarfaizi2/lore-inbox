Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbTARHzK>; Sat, 18 Jan 2003 02:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbTARHzK>; Sat, 18 Jan 2003 02:55:10 -0500
Received: from pop.gmx.net ([213.165.64.20]:12594 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263246AbTARHzK>;
	Sat, 18 Jan 2003 02:55:10 -0500
Message-Id: <5.1.1.6.2.20030118085515.00c99e40@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Sat, 18 Jan 2003 09:00:51 +0100
To: Mikael Pettersson <mikpe@csd.uu.se>, kai@tp1.ruhr-uni-bochum.de
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <15911.64825.624251.707026@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:55 PM 1/17/2003 +0100, Mikael Pettersson wrote:

>Reverting 2.5.59's patch to arch/i386/vmlinux.lds.S cured the
>problem and modules now load correctly for me.

Hi,

Putting . = ALIGN(64) back in front of __start___ksymtab = . 
(vmlinux.lds.h) fixed it here.

         -Mike

