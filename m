Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132796AbREBLkp>; Wed, 2 May 2001 07:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132807AbREBLkf>; Wed, 2 May 2001 07:40:35 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24847 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132796AbREBLkR>; Wed, 2 May 2001 07:40:17 -0400
Subject: Re: ioctl call for network device
To: sebastien.person@sycomore.fr (=?ISO-8859-1?Q?s=E9bastien?= person)
Date: Wed, 2 May 2001 12:44:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (liste noyau linux)
In-Reply-To: <20010502100816.61389ed6.sebastien.person@sycomore.fr> from "=?ISO-8859-1?Q?s=E9bastien?= person" at May 02, 2001 10:08:16 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uv3G-0003Sj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> but I believe that I'm oblige to use the struct ifreq and I can't
> pass any other arguments because an user can't acces kernel space
> so the ioctl call recopy data in the kernel space (this is what I've
> understood, maybe I'm wrong ...).

You can either pass your own data inside of ifr_data[] or you can pass
a pointer in ifr_data and do the copy to/from user space yourself
