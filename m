Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVCIR4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVCIR4p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 12:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVCIR4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 12:56:45 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:34702 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S262150AbVCIR4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 12:56:44 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: RE: [ANNOUNCE][PATCH 2.6.11 2/3] megaraid_sas: Announcing new mod ule  for LSI Logic's SAS based MegaRAID controllers
To: Bagalkote@arcor-online.net, Sreenivas <sreenib@lsil.com>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 09 Mar 2005 18:59:22 +0100
References: <fa.ia0cbem.oiit9q@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1D95St-0000vh-Qo@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bagalkote, Sreenivas <sreenib@lsil.com> wrote:

>>> . And since this is compile time
>>> system-wide property, I kept it as driver global.
>>
>>that step I don't understand... why is it a global *VARIABLE* if it's
>>compile time system-wide property...
>>
> 
> I see your point! Are you saying I should use if(sizeof(dma_addr_t)==8)
> instead of the shortcut if(is_dma64)? Are you thinking of "const" modifier?
> Please advice.

If using a static const variable produces about the same code a macro does,
the variable is OK. Otherwise you'll have to use a #define in order to avoid
including dead code.
