Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265793AbRF2JQM>; Fri, 29 Jun 2001 05:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265797AbRF2JQD>; Fri, 29 Jun 2001 05:16:03 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4868 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265793AbRF2JPn>; Fri, 29 Jun 2001 05:15:43 -0400
Subject: Re: =?utf-8?B?UkU6IFBST0JMRU06SWxsZWdhbCBpbnN0cnVjdGlvbiB3aGVuIG1v?=
To: FrankZhu@viatech.com.cn (=?utf-8?B?RnJhbmsgWmh1IChTaGFuZ2hhaSk=?=)
Date: Fri, 29 Jun 2001 10:14:34 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (=?utf-8?B?J0FsYW4gQ294Jw==?=), mikpe@csd.uu.se,
        bernds@redhat.com,
        FrankZhu@viatech.com.cn (=?utf-8?B?RnJhbmsgWmh1IChTaGFuZ2hhaSk=?=),
        linux-kernel@vger.kernel.org
In-Reply-To: <61F2703C314FD5118C0300010250D52E0580C0@exchsh01.viatech.com.cn> from "=?utf-8?B?RnJhbmsgWmh1IChTaGFuZ2hhaSk=?=" at Jun 29, 2001 10:52:45 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FuME-0008MK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2)the server 192.168.0.254 (netboot) ,client 192.168.0.3
> there are /usr ,/usr/local/ ,/home, /lib, /bin ....... on the server
> on the client
> A: mount -t nfs netboot:/usr  /usr
>     mount -t nfs netboot:/lib /lib
>     mount -t nfs netboot:/bin /bin
>     mount -t nfs netboot:/sbin /sbin
> Illegal instruction (core dumped)

You have i686 cmov using packages on the server, once you replaced the libraries
and some binaries with i686 only ones the inevitable occurred.

If you are sharing your /lib /bin etc you need i586 or lower optimisation 
packages on the server

