Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVFOPf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVFOPf5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 11:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVFOPf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 11:35:57 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:5134 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261177AbVFOPfw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 11:35:52 -0400
Date: Wed, 15 Jun 2005 16:34:59 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: cutaway@bellsouth.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: .../asm-i386/bitops.h  performance improvements
In-Reply-To: <000b01c57187$ade6b9b0$2800000a@pc365dualp2>
Message-ID: <Pine.LNX.4.61L.0506151632280.13835@blysk.ds.pg.gda.pl>
References: <000b01c57187$ade6b9b0$2800000a@pc365dualp2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2005 cutaway@bellsouth.net wrote:

> In find_first_bit() there exists this the sequence:
> 
> shll $3,%%edi
> addl %%edi,%%eax
> 
> LEA knows how to multiply by small powers of 2 and add all in one shot very
> efficiently:
> 
> leal (%%eax,%%edi,8),%%eax

 Be careful about model-specific penalties from using certain address 
modes and AGIs when using "lea" for such calculations.

  Maciej
