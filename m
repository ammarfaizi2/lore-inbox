Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbVKPOgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbVKPOgi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 09:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbVKPOgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 09:36:38 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:37506 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030345AbVKPOgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 09:36:38 -0500
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: arnd@arndb.de
Organization: IBM Deutschland Entwicklung GmbH
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/5] spufs: The SPU file system, base
Date: Wed, 16 Nov 2005 15:38:16 +0100
User-Agent: KMail/1.7.2
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, mnutter@us.ibm.com
References: <20051115205347.395355000@localhost> <17274.49289.583486.477211@cargo.ozlabs.ibm.com> <20051115212638.5dca4a66.akpm@osdl.org>
In-Reply-To: <20051115212638.5dca4a66.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200511161538.17507.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Middeweken 16 November 2005 06:26, Andrew Morton wrote:
> > 
> > Why?  What have you got against MOL? :)
> > 
> 
> The export was moved to mm/memory.c.   No explanation why though...
> 
Sorry about the lack of explanation. There was a short discussion
about this in August, see http://lkml.org/lkml/2005/8/8/205 :

On Mon, 8 Aug 2005 11:42:03 -0700 (PDT), Linus Torvalds wrote: 
> I don't see any reason not to make it global if there are two
> architectures that need it. Especially as long as it's marked GPL-only so 
> that people don't start misusing it.

The __handle_mm_fault symbol is used by spu_base.ko because
the DMA page fault handler calls handle_mm_fault.

Of course at the point where ppc_ksyms.c gets merged into arch/powerpc,
there would again only be one architecture needing it...

	Arnd <><
