Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVCaJhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVCaJhm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 04:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVCaJgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 04:36:50 -0500
Received: from webapps.arcom.com ([194.200.159.168]:50436 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S261265AbVCaJ3T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 04:29:19 -0500
Subject: Re: HELP: PC104 IO card driver Problem
From: Ian Campbell <icampbell@arcom.com>
To: nobin matthew <nobin_matthew@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       kernelnewbies@nl.linux.org
In-Reply-To: <20050331053744.97435.qmail@web53903.mail.yahoo.com>
References: <20050331053744.97435.qmail@web53903.mail.yahoo.com>
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Thu, 31 Mar 2005 10:29:17 +0100
Message-Id: <1112261357.3032.7.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Mar 2005 09:35:58.0140 (UTC) FILETIME=[0B27EFC0:01C535D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 21:37 -0800, nobin matthew wrote:
> The Platform is Arcom Viper borad(with support for
> PC104), This is a Xscale, Little endian Platform.

If you contact Arcom technical support on either euro-support@arcom.com
or us-support@arcom.com then they will be able to help you with any
problems you are having with the VIPER platform.

The answer to your question is that the ISA I/O address space is mapped
at address 0xf7000000 on the VIPER so the address you need to use with
inb() and outb() is actually 0xf7000300 rather than just 0x300. This is
described in the Quickstart manual that ships with the development kit.
There is also a document describing this (because it is an FAQ) in the
support site http://www.arcom.com/support/faq/Embed_Sys.htm#Linux

Cheers,
Ian.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200

