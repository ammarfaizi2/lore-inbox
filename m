Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265629AbRF1KoP>; Thu, 28 Jun 2001 06:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265630AbRF1KoG>; Thu, 28 Jun 2001 06:44:06 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:64782 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265629AbRF1Kns>;
	Thu, 28 Jun 2001 06:43:48 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: ankry@green.mif.pg.gda.pl
cc: jgarzik@mandrakesoft.com (Jeff Garzik), elenstev@mesatop.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.6-pre6 fix drivers/net/Config.in error 
In-Reply-To: Your message of "Thu, 28 Jun 2001 10:45:55 +0200."
             <200106280845.KAA20122@sunrise.pg.gda.pl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Jun 2001 20:43:38 +1000
Message-ID: <6121.993725018@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001 10:45:55 +0200 (MET DST), 
Andrzej Krzysztofowicz <ankry@pg.gda.pl> wrote:
>Keith Owens wrote:
>> Index: 6-pre6.1/drivers/net/Config.in
>> -   dep_bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI
>> +   if [ "$CONFIG_ISA" = "y" -o "$CONFIG_EISA" = "y" -o "$CONFIG_PCI" = "y" ]; then

>CONFIG_EISA check in this condition is redundant.

True, but the line is a cut and paste from higher up in
drivers/net/Config.in.  Even though it is redundant, it is consistent
with the rest of the file.

drivers/net/Config.in needs a major cleanup, lots of the if statements
can go and be replaced by dep_xxx statements, CONFIG_ETHERTAP is marked
obsolete but is tested against experimental, CONFIG_ZNET is marked
experimental but is tested against obsolete, etc.  I started to clean
up the file then decided to leave it, the entire thing is being
replaced in 2.5 anyway.

