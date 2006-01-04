Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWADVBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWADVBu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWADVBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:01:44 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:17029 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751286AbWADVBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:01:23 -0500
Message-ID: <43BC377E.3050603@sgi.com>
Date: Wed, 04 Jan 2006 15:00:46 -0600
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2.6] Altix - ioc3 serial support
References: <200512162233.jBGMXRUQ139857@fsgi900.americas.sgi.com>
In-Reply-To: <200512162233.jBGMXRUQ139857@fsgi900.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There hasn't been any further comments on this - I'm guessing it's ready to go.

Andrew can you take this  ??

-- Pat



The following patch adds driver support for a 2 port PCI IOC3-based
serial card on Altix boxes:

ftp://oss.sgi.com/projects/sn2/sn2-update/044-ioc3-support

  arch/ia64/configs/gensparse_defconfig |    2
  arch/ia64/configs/sn2_defconfig       |    2
  drivers/serial/Kconfig                |    9
  drivers/serial/Makefile               |    1
  drivers/serial/ioc3_serial.c          | 2231 ++++++++++++++++++++++++++++++++++
  drivers/sn/Kconfig                    |   14
  drivers/sn/Makefile                   |    1
  drivers/sn/ioc3.c                     |  851 ++++++++++++
  include/asm-ia64/sn/ioc3.h            |  241 +++
  include/linux/ioc3.h                  |   93 +



This is a re-submission. On the original submission I was asked to
organize the code so that the MIPS ioc3 ethernet and serial parts could
be used with this driver. Stanislaw Skowronek was kind enough to
provide the shim layer for this - thanks Stanislaw. This patch includes
the shim layer and the Altix PCI ioc3 serial driver. The MIPS merged
ioc3 ethernet and serial support is forthcoming.

Signed-off-by: Patrick Gefre <pfg@sgi.com>
