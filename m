Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266654AbUHBRXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266654AbUHBRXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 13:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266655AbUHBRXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 13:23:12 -0400
Received: from jade.spiritone.com ([216.99.193.136]:55213 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S266654AbUHBRXJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 13:23:09 -0400
Date: Mon, 02 Aug 2004 10:23:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: jmoyer@redhat.com
cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: finding out the boot cpu number from userspace
Message-ID: <30660000.1091467382@[10.10.2.4]>
In-Reply-To: <16654.29342.977105.723775@segfault.boston.redhat.com>
References: <20040802121635.GE14477@devserv.devel.redhat.com><12690000.1091461852@[10.10.2.4]> <16654.29342.977105.723775@segfault.boston.redhat.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ==> Regarding Re: finding out the boot cpu number from userspace; "Martin J. Bligh" <mbligh@aracnet.com> adds:
> 
>>> assuming cpu 0 is the boot cpu sounds fragile/incorrect, but for
>>> irqbalanced I'd like to find out which cpu is the boot cpu, is there a
>>> good way of doing so ?
>>> 
>>> The reason for needing this is that some firmware only likes running on
>>> the boot cpu so I need to bind firmware-related irq's to that cpu
>>> ideally.
> 
> mbligh> On any sane arch, cpu 0 *IS* always the boot CPU, as we dynamically
> mbligh> number CPUs that way ... that doesn't mean that it's apicid 0. I
> mbligh> believe that PPC64 screwed this up, but AFAIK, everyone else gets
> mbligh> it correct ... ;-)
> 
> Hmm, do we need to do any special handling for this in the kexec case?
> ISTR having some issues with this when using bootimg years back.

Eric went to some lengths to migrate us back to the original boot CPU 
before kexec'ing. I think this is unnecessary - the new kernel should
handle booting on any CPU just fine (there was a panic in there at one
point if the boot CPU didn't match the BIOS's spec'ed one, but I removed
it).

M.

