Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269530AbTGJUfb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 16:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269587AbTGJUfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 16:35:31 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:43692 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S269530AbTGJUfZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 16:35:25 -0400
Subject: Re: [PATCH] linux-2.4.22-pre4_x440-acpi-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrew Grover <andrew.grover@intel.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55L.0307100019460.6316@freak.distro.conectiva>
References: <1057799280.27380.248.camel@w-jstultz2.beaverton.ibm.com>
	 <Pine.LNX.4.55L.0307100019460.6316@freak.distro.conectiva>
Content-Type: text/plain
Organization: 
Message-Id: <1057870055.22133.152.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Jul 2003 13:47:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-09 at 20:22, Marcelo Tosatti wrote:
> On Wed, 9 Jul 2003, john stultz wrote:
> > 	Due to the new ACPI code, when booting in full ACPI mode, we do not go
> > through the mps tables, thus we do not execute the summit detection code
> > required for booting an x440.
> >
> > This patch insures that when booting in full ACPI mode we check to see
> > if we're running on a summit based system and enable clustered apic
> > mode. Without this patch the x440s hang while booting in full ACPI mode.
>
> I just applied it John, it will be in bk soon.

Thanks so much.

> But cant that be done in a cleaner way?
> 
> The acpi_madt_oem_check() call and implementation are the cleaner way of
> doing this?

Well,when booting using the acpi tables, we need an equivalent hook to
detect_clustered_apic(), which is used when booting off the mps table.

Basically I just kept the acpi_madt_oem_check() name and implementation
from the 2.5 tree, but I'd be fine with doing it differently if someone
can suggest an idea. 

thanks
-john

