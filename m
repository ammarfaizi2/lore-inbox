Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132398AbRDUBJw>; Fri, 20 Apr 2001 21:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132400AbRDUBJn>; Fri, 20 Apr 2001 21:09:43 -0400
Received: from jalon.able.es ([212.97.163.2]:10226 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132398AbRDUBJi>;
	Fri, 20 Apr 2001 21:09:38 -0400
Date: Sat, 21 Apr 2001 03:09:30 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac11
Message-ID: <20010421030930.A29461@werewolf.able.es>
In-Reply-To: <E14qlRA-0002d4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14qlRA-0002d4-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Apr 21, 2001 at 02:39:42 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.21 Alan Cox wrote:
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/

gcc-2.96 spits warnings about possibly-used-before-initialized vars in
mtrr.c, line 2004:

static void __init centaur_mcr_init(void)
{
	int lo,hi;
..
	if (anything)
		set hi,lo
	<else ??? unset>
..
	use lo, hi all around
}

Perhaps it never can happen, but...

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3-ac9 #1 SMP Wed Apr 18 10:35:48 CEST 2001 i686

