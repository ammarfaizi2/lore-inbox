Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266209AbUHSOMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266209AbUHSOMX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 10:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUHSOMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 10:12:23 -0400
Received: from host-ip82-243.crowley.pl ([62.111.243.82]:57860 "HELO
	software.com.pl") by vger.kernel.org with SMTP id S266209AbUHSOMT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 10:12:19 -0400
From: Karol Kozimor <kkozimor@aurox.org>
Organization: Aurox Sp. z o.o.
To: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Re: 2.6.8.1-mm1 hangs on boot with ACPI
Date: Thu, 19 Aug 2004 16:12:47 +0200
User-Agent: KMail/1.6.2
Cc: "Li, Shaohua" <shaohua.li@intel.com>, <eric.valette@free.fr>,
       "Brown, Len" <len.brown@intel.com>,
       "Pontus Fuchs" <pontus.fuchs@tactel.se>, "Greg KH" <greg@kroah.com>,
       <acpi-devel@lists.sourceforge.net>
References: <B44D37711ED29844BEA67908EAF36F039A1A4E@pdsmsx401.ccr.corp.intel.com>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F039A1A4E@pdsmsx401.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408191612.48033.kkozimor@aurox.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 of August 2004 15:54, Li, Shaohua wrote:
> Why this breaks ACPI? ACPI just try to reserve the IO port declared in
> DSDT (ACPI itself doesn't use the io ports), but if the attempt failed,

_TMP indirectly tries (and fails) to access HSTS field which is in the 
reserved region. Furthermore, the loop in the HBSY method that gets 
referenced keeps kacpid very busy during (possibly) thermal interrupt 
handling, thus increasing the system load and temperature, and in turn, 
the frequency of thermal notifies.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
