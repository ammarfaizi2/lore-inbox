Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266619AbUHBRAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbUHBRAY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 13:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUHBRAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 13:00:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18123 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266619AbUHBRAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 13:00:19 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16654.29342.977105.723775@segfault.boston.redhat.com>
Date: Mon, 2 Aug 2004 12:58:06 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: finding out the boot cpu number from userspace
In-Reply-To: <12690000.1091461852@[10.10.2.4]>
References: <20040802121635.GE14477@devserv.devel.redhat.com>
	<12690000.1091461852@[10.10.2.4]>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: finding out the boot cpu number from userspace; "Martin J. Bligh" <mbligh@aracnet.com> adds:

>> assuming cpu 0 is the boot cpu sounds fragile/incorrect, but for
>> irqbalanced I'd like to find out which cpu is the boot cpu, is there a
>> good way of doing so ?
>> 
>> The reason for needing this is that some firmware only likes running on
>> the boot cpu so I need to bind firmware-related irq's to that cpu
>> ideally.

mbligh> On any sane arch, cpu 0 *IS* always the boot CPU, as we dynamically
mbligh> number CPUs that way ... that doesn't mean that it's apicid 0. I
mbligh> believe that PPC64 screwed this up, but AFAIK, everyone else gets
mbligh> it correct ... ;-)

Hmm, do we need to do any special handling for this in the kexec case?
ISTR having some issues with this when using bootimg years back.

-Jeff
