Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316135AbSFYXbd>; Tue, 25 Jun 2002 19:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316158AbSFYXbc>; Tue, 25 Jun 2002 19:31:32 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:45965 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S316135AbSFYXbb>; Tue, 25 Jun 2002 19:31:31 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: "'lkml'" <linux-kernel@vger.kernel.org>
Subject: DMA from high memory regions
Date: Tue, 25 Jun 2002 16:29:58 -0700
Message-ID: <002501c21ca0$3940ac40$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20020625230607.GA13960@netnation.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to setup DMA to/from user space. I get a user pointer in my
device driver, from which I build up kiobuf and call map_user_kiobuf. After
this, I call kmap to map pages to kernel virtual space and then virt_to_bus
to get bus address. Now if I define CONFIG_HIGHMEM and that page happens to
be in the memory region near 1GB then DMA never happens and I donot see any
data in result pointer. If CONFIG_HIGHMEM is not defined, then everything
works perfectly. Please suggest any solution.

Thanks,
Imran.



