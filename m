Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266576AbSKLNtZ>; Tue, 12 Nov 2002 08:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266578AbSKLNtY>; Tue, 12 Nov 2002 08:49:24 -0500
Received: from ausadmmsps306.aus.amer.dell.com ([143.166.224.101]:12816 "HELO
	AUSADMMSPS306.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S266576AbSKLNtY>; Tue, 12 Nov 2002 08:49:24 -0500
X-Server-Uuid: c21c953d-96eb-4242-880f-19bdb46bc876
Message-ID: <20BF5713E14D5B48AA289F72BD372D68C1EB7C@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: amd@tt.ee, linux-kernel@vger.kernel.org
Subject: RE: 2.5.47: make modules_install fails
Date: Tue, 12 Nov 2002 07:56:06 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 11CFD7F2735809-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> when doing make modules_install, it fails with the following error
> messages:
> depmod: *** Unresolved symbols in 
> /lib/modules/2.5.47/kernel/drivers/net/8390.o
> depmod:         crc32_be_Rb7b61546
> depmod:         crc32_be_Rb7b61546

For the crc32 bits, you've got CONFIG_CRC32=y, but CONFIG_SMC91C92=m, and
nothing built-in is using the crc32 functions, so the linker is throwing
them out.  Set CONFIG_CRC32=m, if something built-in needs it it'll get set
to =y by them.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

