Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbUDIEG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 00:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUDIEG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 00:06:57 -0400
Received: from mail0.lsil.com ([147.145.40.20]:16870 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261158AbUDIEGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 00:06:54 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC50C@exa-atlanta.se.lsil.com>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Paul Wagland'" <paul@kungfoocoder.org>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'jgarzik@pobox.com'" <jgarzik@pobox.com>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "'James.Bottomley@SteelEye.com'" <James.Bottomley@SteelEye.com>,
       "'arjanv@redhat.com'" <arjanv@redhat.com>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [ANNOUNCE][RELEASE]: megaraid unified driver version 2.20.0.B
	1
Date: Fri, 9 Apr 2004 00:05:49 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>OK, I have started to look at this driver, I have come across one
Good!

>problem, which the attached patch fixes. This patch has been sent
>through the list several times and has been accepted into 2.6.5.
Taken, would be added asap

>1. The Kconfig.megaraid and Makefile.2.6 files from the alpha release
>are not in the beta.
Will be added in next drop

>2. In mraid_pci_blk_pool_destroy(), the caller "guarantees that no more
>memory from the pool is in use", however, they don't have to guarantee
>that pool is not null. Why? In fact, in the code it appears that this
>guarantee is also made...
Now you are reading between the lines :-) Just consider clib to be
independently implemented and has some safety checks

>3. I am not sure what the local conventions on this are, but in
>megaraid_alloc_cmd_packets() if the first allocation fails then we
>return straight away, in all other cases we do a goto fail_alloc_cmds;
Accepted..

>4. Also a consistency issue: In megaraid_mbox_mm_cmd() we handle the
>deletion of a logical drive specially, by calling
>megaraid_mbox_del_logdrv(), which just ensures that the drives are
Good catch.

Thanks!
-Atul Mukker
LSI Logic
