Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbTGHIh0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 04:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbTGHIh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 04:37:26 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:47532 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S265100AbTGHIhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 04:37:25 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Martin Schlemmer <azarah@gentoo.org>
Subject: Re: 2.5.74-mm2 + nvidia (and others)
Date: Tue, 8 Jul 2003 10:51:39 +0200
User-Agent: KMail/1.5.9
Cc: Andrew Morton <akpm@osdl.org>, smiler@lanil.mine.nu,
       KML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <1057590519.12447.6.camel@sm-wks1.lan.irkk.nu> <1057647818.5489.385.camel@workshop.saharacpt.lan> <20030708072604.GF15452@holomorphy.com>
In-Reply-To: <20030708072604.GF15452@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307081051.41683.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 July 2003 09:26, William Lee Irwin III wrote:
> On Tue, Jul 08, 2003 at 09:03:39AM +0200, Martin Schlemmer wrote:
> > Bit too specific to -mm2, what about the the attached?
>
> Well, it'd also help to check whether this is a userspace address or
> a kernelspace address. Kernelspace access would only require
> pmd_offset_kernel().
>
> Where are these nvidia and vmware patches, anyway? I can maintain
> fixups for highpmd for the things and it would at least help me a
> bit to see what's going on around the specific areas.

Well, the NVIDIA patches are at
   http://www.minion.de/nvidia.html
but I don't know about the VMWARE patches...

Btw, what do you think about the idea of exporting the follow_pages() function 
from mm/memory.c to kernel modules? So this could be used for modules 
compiled for 2.[56] kernels and the old way just for 2.4 kernels...
