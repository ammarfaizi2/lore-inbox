Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281304AbRKMAnT>; Mon, 12 Nov 2001 19:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281297AbRKMAnJ>; Mon, 12 Nov 2001 19:43:09 -0500
Received: from jalon.able.es ([212.97.163.2]:31475 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S281304AbRKMAm4>;
	Mon, 12 Nov 2001 19:42:56 -0500
Date: Tue, 13 Nov 2001 01:42:48 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
Message-ID: <20011113014248.A1487@werewolf.able.es>
In-Reply-To: <20011113004846.G1531@werewolf.able.es> <200111130014.fAD0Eel15650@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200111130014.fAD0Eel15650@ns.caldera.de>; from hch@ns.caldera.de on Tue, Nov 13, 2001 at 01:14:40 +0100
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011113 Christoph Hellwig wrote:
>In article <20011113004846.G1531@werewolf.able.es> you wrote:
>>
>> This is an update-cleanup of the i2c code to the current CVS. In short,
>> it adds version info printing and some CONFIG_ cleanups (there were
>> CONFIG_ vars defined in Config.in that had been renamed inside the code).
>> Please consider for next pre of 2.4.15.
>
>Could you please think before doing a merge next time?
>The patch backs out local changes like ite support:
>
>> -obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
>> -obj-$(CONFIG_ITE_I2C_ALGO)	+= i2c-algo-ite.o
>> -obj-$(CONFIG_ITE_I2C_ADAP)	+= i2c-adap-ite.o
>> +obj-$(CONFIG_I2C_PCFISA)	+= i2c-elektor.o
>>  obj-$(CONFIG_I2C_PROC)		+= i2c-proc.o
>
>	Christoph

This should also stay, so ?

-   if [ "$CONFIG_MIPS_ITE8172" = "y" ]; then
-      dep_tristate 'ITE I2C Algorithm' CONFIG_ITE_I2C_ALGO $CONFIG_I2C
-      if [ "$CONFIG_ITE_I2C_ALGO" != "n" ]; then
-         dep_tristate '  ITE I2C Adapter' CONFIG_ITE_I2C_ADAP $CONFIG_ITE_I2C_ALGO
-      fi
-   fi


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.15-pre4-beo #2 SMP Tue Nov 13 00:50:12 CET 2001 i686
