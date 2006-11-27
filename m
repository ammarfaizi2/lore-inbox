Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757046AbWK0FfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757046AbWK0FfL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 00:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757050AbWK0FfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 00:35:11 -0500
Received: from hera.kernel.org ([140.211.167.34]:27311 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1757046AbWK0FfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 00:35:09 -0500
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: "Yinghai Lu" <yinghai.lu@amd.com>
Subject: Re: [PATCH 3/3] x86: when acpi_noirq is set, use mptable instead of MADT
Date: Mon, 27 Nov 2006 00:37:53 -0500
User-Agent: KMail/1.8.2
Cc: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
References: <86802c440611261524p6b170f50rf7db3eafd4f7602e@mail.gmail.com>
In-Reply-To: <86802c440611261524p6b170f50rf7db3eafd4f7602e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611270037.53964.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"acpi=noirq" and "pci=noacpi" are not reliable in IOAPIC mode --
as, by definition, they skip the processing of the ACPI interrupt itself.
On some systems this happens to work, and on some systems it doesn't --
depends on if there was an override for the SCI or if it appears as
a standard PCI interrupt.

So the bigger question is why you need these workarounds in the first place.

-Len



