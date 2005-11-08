Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbVKHNVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbVKHNVs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 08:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbVKHNVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 08:21:48 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:56631
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S964981AbVKHNVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 08:21:47 -0500
Message-Id: <4370B4B2.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 14:22:42 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Arjan Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386: export genapic again
References: <4370AEE1.76F0.0078.0@novell.com> <1131455290.2789.15.camel@laptopd505.fenrus.org>
In-Reply-To: <1131455290.2789.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Arjan van de Ven <arjan@infradead.org> 08.11.05 14:08:09 >>>
>On Tue, 2005-11-08 at 13:57 +0100, Jan Beulich wrote:
>> A change not too long ago made i386's genapic symbol no longer be
>> exported, and thus certain low-level functions no longer be usable.
>> Since close-to-the-hardware code may still be modular, this
>> rectifies the situation.
>> 
>> From: Jan Beulich <jbeulich@novell.com>
>> 
>> (actual patch attached)
>> 
>
>+#define APIC_DEFINITION 1
>
>what is that for?

For making the whole thing build: asm/smp.h and
asm/mach-generic/apicdef.h contain some constructs that result in build
failures when visible to some of the files that actually implement
(parts of) the APIC stuff. For this specific file,
hard_smp_processor_id() would otherwise be defined twice.

Jan


