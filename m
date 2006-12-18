Return-Path: <linux-kernel-owner+w=401wt.eu-S1754479AbWLRTqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbWLRTqa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 14:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754481AbWLRTqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 14:46:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:6313 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479AbWLRTq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 14:46:28 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,185,1165219200"; 
   d="scan'208"; a="179007428:sNHT19721688"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Kirill Korotaev'" <dev@openvz.org>, "Luck, Tony" <tony.luck@intel.com>,
       <linux-ia64@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Alexey Kuznetsov" <alexey@openvz.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <devel@openvz.org>
Subject: RE: [PATCH] IA64: alignment bug in ldscript
Date: Mon, 18 Dec 2006 11:23:29 -0800
Message-ID: <000001c722d9$ffb63f90$e834030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccioMlKUspGtWt/Tbm7MqJltz7ayAAOCCAg
In-Reply-To: <458683CF.8030606@openvz.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote on Monday, December 18, 2006 4:05 AM
> [IA64] bug in ldscript (mainstream)
> 
> Occasionally, in mainstream number of fsys entries is even.

Is it a typo on "fsys entries is even"?

If not, then this change log is misleading. It is the instruction
patch list of FSYS_RETURN that can potentially cause other data
structures to be out of alignment. And number of FSYS_RETURN call
site will not necessarily match number of fsys entry.


> In OpenVZ it is odd and we get misaligned kernel image,
> which does not boot.

Otherwise, the patch looks fine to me.
