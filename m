Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284537AbRLRSlp>; Tue, 18 Dec 2001 13:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284542AbRLRSkS>; Tue, 18 Dec 2001 13:40:18 -0500
Received: from m851-mp1-cvx1c.edi.ntl.com ([62.253.15.83]:20462 "EHLO
	pinkpanther.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284467AbRLRSii>; Tue, 18 Dec 2001 13:38:38 -0500
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200112181524.fBIFO9v16051@pinkpanther.swansea.linux.org.uk>
Subject: Re: modify_ldt returning ENOMEM on highmem machine
To: h.lubitz@internet-factory.de (Holger Lubitz)
Date: Tue, 18 Dec 2001 15:24:08 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C1E005F.E189A18A@internet-factory.de> from "Holger Lubitz" at Dec 17, 2001 03:25:35 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried posting this before, but apparently it didn't get through to the
> list.
> The following are the final lines of a strace of a failing mplayer:

glibc 2.2 uses lots of ldt's which get vmalloced. Our vmalloc address space
is way too small on big boxes. Grab the patch posted to the kernel list
to only vmalloc large ldts and the box will be fine

Highmem isnt a direct link but large memory boxes are the most problematic

