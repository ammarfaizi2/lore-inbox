Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266318AbSKZO4N>; Tue, 26 Nov 2002 09:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbSKZO4N>; Tue, 26 Nov 2002 09:56:13 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:54161 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266318AbSKZO4N>; Tue, 26 Nov 2002 09:56:13 -0500
Subject: Re: [patch] IDE fix for current -bk
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3DE306E4.26E746BA@digeo.com>
References: <3DE306E4.26E746BA@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Nov 2002 15:05:49 +0000
Message-Id: <1038323149.2594.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-26 at 05:30, Andrew Morton wrote:
> do_ide_setup_pci_device() is returning an uninitialised
> ata_index_t causing an oops at bootup.

Its initialized by ide_pci_setup_ports

	index->all = 0xF0F0

but yes you are right - the error path can return it uninitialized. 

