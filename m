Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268346AbUJTEdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268346AbUJTEdF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 00:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268342AbUJTEdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 00:33:04 -0400
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:63847 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268346AbUJTEc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 00:32:28 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] RE: PATCH/RFC: driver model/pmcore wakeup hooks (1/4)
Date: Tue, 19 Oct 2004 22:51:13 -0500
User-Agent: KMail/1.6.2
Cc: "Li, Shaohua" <shaohua.li@intel.com>,
       "David Brownell" <david-b@pacbell.net>,
       "Brown, Len" <len.brown@intel.com>, "Pavel Machek" <pavel@ucw.cz>,
       <linux-kernel@vger.kernel.org>
References: <16A54BF5D6E14E4D916CE26C9AD3057559A042@pdsmsx402.ccr.corp.intel.com>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD3057559A042@pdsmsx402.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410192251.14740.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 October 2004 04:11 am, Li, Shaohua wrote:
> A final solution is device core adds an ACPI layer. That is we can link
> ACPI device and physical device. This way, the PCI device can know which
> ACPI is linked with it, so the PCI API can use specific ACPI method. 
> You are right, we currently haven't a method to reach the goal. To match
> a physical device and ACPI device, we need to know the ACPI device's
> _ADR and bus.
> I have a toy to link the PCI device and ACPI device, and some PCI
> function can use _SxD method and _PSx method to get some information for
> suspend/resume.
> 

The only caveat is that PCI core should not depend on ACPI because it is not
available on all platforms, not all world is x86.

-- 
Dmitry
