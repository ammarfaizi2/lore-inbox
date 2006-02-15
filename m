Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWBOXMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWBOXMa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 18:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWBOXMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 18:12:30 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:17027 "EHLO
	vrapenec.doma") by vger.kernel.org with ESMTP id S1751216AbWBOXM3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 18:12:29 -0500
Message-ID: <43F3B553.2010506@ribosome.natur.cuni.cz>
Date: Thu, 16 Feb 2006 00:12:19 +0100
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051002
X-Accept-Language: cs
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.16-rc3-git5: drivers/acpi/osl.c:57:38: empty filename in #include
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I have the following problem when compiling linux kernel on Intel 
Pentium4M machine:

drivers/acpi/osl.c:57:38: empty filename in #include
drivers/acpi/osl.c: In function `acpi_os_table_override':
drivers/acpi/osl.c:258: error: `AmlCode' undeclared (first use in 
this function)
drivers/acpi/osl.c:258: error: (Each undeclared identifier is 
reported only once
drivers/acpi/osl.c:258: error: for each function it appears in.)
make[2]: *** [drivers/acpi/osl.o] Error 1

   It turned out I have enabled the custom DSDT option but the field 
for the custom file have left empty. That's the cause for the error.
Something should probably take care of this case. I use "menuconfig"
to manipulate the .config file.
M.
