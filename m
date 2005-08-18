Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbVHRV2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbVHRV2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 17:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVHRV2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 17:28:13 -0400
Received: from dvhart.com ([64.146.134.43]:35969 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932458AbVHRV2N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 17:28:13 -0400
Date: Thu, 18 Aug 2005 14:28:08 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: idle task's task_t allocation on NUMA machines
Message-ID: <1704890000.1124400488@flay>
In-Reply-To: <20050818200255.GI8822@bouh.labri.fr>
References: <20050818140829.GB8123@implementation.labri.fr> <4304A6DF.6040703@cosmosbay.com> <20050818194941.GH8822@bouh.labri.fr> <20050818200255.GI8822@bouh.labri.fr>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, August 18, 2005 22:02:55 +0200 Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:

> Samuel Thibault, le Thu 18 Aug 2005 21:49:41 +0200, a écrit :
>> Eric Dumazet, le Thu 18 Aug 2005 17:18:55 +0200, a écrit :
>> > I believe IRQ stacks are also allocated on node 0, that seems more serious.
>> 
>> For the i386 architecture at least, yes: they are statically defined in
>> arch/i386/kernel/irq.c, while they could be per_cpu.
> 
> Hum, but the per_cpu areas for i386 are not numa-aware... I'm wondering:
> isn't the current x86_64 numa-aware implementation of per_cpu generic
> enough for any architecture?

All ZONE_NORMAL on ia32 is on node 0, so I don't think it'll help.

M.

