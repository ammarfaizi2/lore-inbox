Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319169AbSHNAS5>; Tue, 13 Aug 2002 20:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319170AbSHNAS5>; Tue, 13 Aug 2002 20:18:57 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:15062 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S319169AbSHNAS4>; Tue, 13 Aug 2002 20:18:56 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: "'Ralf Baechle'" <ralf@linux-mips.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Cache coherency and snooping
Date: Tue, 13 Aug 2002 17:19:56 -0700
Message-ID: <0a9c01c24328$5205f470$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20020814020825.A11382@linux-mips.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Ralf and Alan,

What if I allocate memory at boot-time using alloc_bootmem*(..)?

Imran.


-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org]
Sent: Tuesday, August 13, 2002 5:08 PM
To: Imran Badr
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cache coherency and snooping


On Tue, Aug 13, 2002 at 04:22:31PM -0700, Imran Badr wrote:

> How can I define a certain region of memory so that it is never cached? I
> want to use non-cached region of memory to communicate to my PCI device to
> avoid system overhead in cache snooping.

On every sane platform the hardware performs better at keeping the
coherency than software ever could.  Don't even think about it unless
you for some reason absolutely must disable caching.  Aside and as Alan
already mentioned the allocation of uncached memory isn't supported.

  Ralf

