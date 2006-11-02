Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752764AbWKBJQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbWKBJQR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 04:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbWKBJQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 04:16:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15520 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752764AbWKBJQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 04:16:15 -0500
Subject: Re: Can Linux live without DMA zone?
From: Arjan van de Ven <arjan@infradead.org>
To: Jun Sun <jsun@junsun.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061102021547.GA1240@srv.junsun.net>
References: <20061102021547.GA1240@srv.junsun.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 02 Nov 2006 10:16:11 +0100
Message-Id: <1162458971.14530.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 18:15 -0800, Jun Sun wrote:
> I am trying to reserve a block of memory (>16MB) starting from 0 and hide it 
> from kernel.  A consequence is that DMA zone now has size 0.  That causes
> many drivers to grief (OOMs).
> 
> I see two ways out:
> 
> 1. Modify individual drivers and convince them not to alloc with GFP_DMA.
>    I have been trying to do this but do not seem to see an end of it.  :)
> 
> 2. Simply lie and increase MAX_DMA_ADDRESS to really big (like 1GB) so that
>    the whole memory region belongs to DMA zone.
> 
> #2 sounds pretty hackish.  I am sure something bad will happen
> sooner or later (like what?). But so far it appears to be working fine.
> 
> The fundamental question is: Has anybody tried to run Linux without 0 sized
> DMA zone before?  Am I doing something that nobody has done before (which is
> something really hard to believe these days with Linux :P)?

on a PC there are still devices that need memory in the lower 16Mb.....
(like floppy)

Maybe you should reserve another area of memory instead!


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

