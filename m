Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVCIRqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVCIRqA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 12:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVCIRqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 12:46:00 -0500
Received: from mail0.lsil.com ([147.145.40.20]:44965 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262150AbVCIRpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 12:45:15 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230CC20@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'Arjan van de Ven'" <arjan@infradead.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>
Subject: RE: [ANNOUNCE][PATCH 2.6.11 2/3] megaraid_sas: Announcing new mod
	 ule  for LSI Logic's SAS based MegaRAID controllers
Date: Wed, 9 Mar 2005 12:44:14 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >
>> >> . And since this is compile time
>> >> system-wide property, I kept it as driver global.
>> >
>> >that step I don't understand... why is it a global 
>*VARIABLE* if it's
>> >compile time system-wide property...
>> >
>> 
>> I see your point! Are you saying I should use 
>if(sizeof(dma_addr_t)==8)
>> instead of the shortcut if(is_dma64)? 
>yep
>well you can use a preprocessor define of something to make it slightly
>more readable (eg shortcut) if you want, but that's what I mean yeah..
>
>gcc will optimize the entire unused code away this way, including the
>actual conditional jump, so for performance and bloat-ness 
>point of view
>it's nice.... and of course generic design beauty ;)
>

Great. Thanks! I will change it. If I understand you correctly, I should
#define IS_DMA64 (sizeof(dma_addr_t)==8).

Is this better than declaring is_dma64 global variable const? (Excuse the
oxymoron).
