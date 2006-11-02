Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752699AbWKBHML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbWKBHML (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 02:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbWKBHML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 02:12:11 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:58013 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S1752699AbWKBHMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 02:12:10 -0500
Subject: RE: Can Linux live without DMA zone?
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Conke Hu <conke.hu@amd.com>
Cc: Jun Sun <jsun@junsun.net>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
In-Reply-To: <FFECF24D2A7F6D418B9511AF6F358602F2D4E1@shacnexch2.atitech.com>
References: <FFECF24D2A7F6D418B9511AF6F358602F2D4E1@shacnexch2.atitech.com>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Nov 2006 08:13:11 +0100
Message-Id: <1162451591.27131.2.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 11:43 +0800, Conke Hu wrote:
> It seems a good idea.
> Is dma zone is still necessay on most modern computers?

(don't top post!)

if you would have used google, you'd have found this:
  http://www.mail-archive.com/linux-arch@vger.kernel.org/msg01623.html


cheers

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jun Sun
> Sent: 2006年11月2日 10:16
> To: linux-kernel@vger.kernel.org
> Subject: Can Linux live without DMA zone?
> 
> 
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
> 
> Cheers.
> 
> Jun
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

