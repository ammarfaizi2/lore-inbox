Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTKXVZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 16:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbTKXVZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 16:25:28 -0500
Received: from CPE000102d0fe24-CM0f1119830776.cpe.net.cable.rogers.com ([65.49.144.24]:43525
	"EHLO thorin.norang.ca") by vger.kernel.org with ESMTP
	id S261879AbTKXVZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 16:25:26 -0500
Date: Mon, 24 Nov 2003 16:25:10 -0500
From: Bernt Hansen <bernt@norang.ca>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: Toshiba ACPI battery status - ACPI errors
Message-ID: <20031124212510.GA9628@norang.ca>
Mail-Followup-To: "Nakajima, Jun" <jun.nakajima@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Developers <acpi-devel@lists.sourceforge.net>,
	"Brown, Len" <len.brown@intel.com>
References: <7F740D512C7C1046AB53446D37200173618752@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D37200173618752@scsmsx402.sc.intel.com>
Organization: Norang Consulting Inc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jun,

I'd be happy to provide any data to get this problem fixed... how do I
generate an ACPI dump?  I've never done that before.

Bernt

On Mon, Nov 24, 2003 at 01:04:22PM -0800, Nakajima, Jun wrote:
> I suspect this is a known issue with AML code from Toshiba. Their _STA
> does not return a value explicitly, but (wrongly) expects the AML
> interpreter to get the return value returned by the function _STA is
> calling, like
> 	Method (_STA, ....) {
> 		AAA(...)
> 	}
> Instead of 
> 	Method (_STA, ....) {
> 		Return (AAA(...))
> 	}
> 
> If you can provide ACPI dump data of the machine, that would be helpful
> when identifying the cause. Copy the ACPI mailing list and Len.
-- 
Bernt Hansen     Norang Consulting Inc.
