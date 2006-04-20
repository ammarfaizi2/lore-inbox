Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWDTRXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWDTRXR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWDTRXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:23:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55444 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751085AbWDTRXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:23:15 -0400
Date: Thu, 20 Apr 2006 13:23:00 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ken@krwtech.com, linux-kernel@vger.kernel.org
Subject: Re: Advansys SCSI driver and 2.6.16
Message-ID: <20060420172300.GA19181@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, ken@krwtech.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0604191444200.1841@death> <20060419163247.6986a87c.akpm@osdl.org> <20060419224202.3e2f99f5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419224202.3e2f99f5.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 10:42:02PM -0700, Andrew Morton wrote:

 > --- devel/drivers/scsi/Kconfig~a	2006-04-19 22:39:51.000000000 -0700
 > +++ devel-akpm/drivers/scsi/Kconfig	2006-04-19 22:40:00.000000000 -0700
 > @@ -453,7 +453,7 @@ config SCSI_DPT_I2O
 >  
 >  config SCSI_ADVANSYS
 >  	tristate "AdvanSys SCSI support"
 > -	depends on (ISA || EISA || PCI) && SCSI && BROKEN
 > +	depends on (ISA || EISA || PCI) && SCSI
 >  	help
 >  	  This is a driver for all SCSI host adapters manufactured by
 >  	  AdvanSys. It is documented in the kernel source in
 > _
 > 
 > and it does compile.   Does it actually work?

It doesn't work on all architectures, but for the one most
people care about (x86), it seems to have quite a few happy users.
(I got a slew of bug reports in Fedora bugzilla when it disappeared,
 and resurrected it with the exact same patch you did).

		Dave

-- 
http://www.codemonkey.org.uk
