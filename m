Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269678AbUJGEBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269678AbUJGEBV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 00:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269679AbUJGEBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 00:01:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58250 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269678AbUJGEBT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 00:01:19 -0400
Message-ID: <4164BF82.2040608@pobox.com>
Date: Thu, 07 Oct 2004 00:01:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, alan@redhat.com,
       david.balazic@hermes.si
Subject: Re: [PATCH 2.6.9-rc3-mm2] EDD: use EXTENDED READ command, add CONFIG_EDD_SKIP_MBR
References: <20041004214803.GC2989@lists.us.dell.com>
In-Reply-To: <20041004214803.GC2989@lists.us.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
> Some controller BIOSes have problems with the legacy int13 fn02 READ
> SECTORS command.  int13 fn42 EXTENDED READ is used in preference by
> most boot loaders today, so lets use that.  If EXTENDED READ fails or
> isn't supported, fall back to READ SECTORS.
> 
> This hopefully resolves the three reports of BIOSes which would either
> long-pause (30+ seconds) or hang completely on the legacy READ SECTORS
> command.
> 
> This also adds CONFIG_EDD_SKIP_MBR to eliminate reading the MBR on
> each BIOS-presented disk, in case there are further problems in this
> area.


Build fails on x86-64:

[...]
   SYSMAP  System.map
   SYSMAP  .tmp_System.map
   AS      arch/x86_64/boot/setup.o
In file included from arch/x86_64/boot/setup.S:536:
arch/i386/boot/edd.S:17: macro names must be identifiers
make[1]: *** [arch/x86_64/boot/setup.o] Error 1
make: *** [bzImage] Error 2
