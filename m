Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbWJILn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbWJILn7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 07:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbWJILn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 07:43:59 -0400
Received: from ns1.suse.de ([195.135.220.2]:59557 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932569AbWJILn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 07:43:58 -0400
Date: Mon, 9 Oct 2006 13:41:50 +0200
From: Stefan Seyfried <seife@suse.de>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, rdunlap@xenotime.net, jgarzik@pobox.com,
       linux-ide@vger.kernel.org
Subject: Re: [patch 1/2] libata: _GTF support
Message-ID: <20061009114150.GA32716@suse.de>
References: <20060927223441.205181000@localhost.localdomain> <20060927153627.c931de2d.kristen.c.accardi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060927153627.c931de2d.kristen.c.accardi@intel.com>
X-Operating-System: SUSE Linux Enterprise Desktop 10 (i586), Kernel 2.6.18-9-default
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 03:36:27PM -0700, Kristen Carlson Accardi wrote:
> _GTF is an acpi method that is used to reinitialize the drive.  It returns
> a task file containing ata commands that are sent back to the drive to restore
> it to boot up defaults.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> 
> ---
>  Documentation/kernel-parameters.txt |    5 
 
> --- 2.6-mm.orig/Documentation/kernel-parameters.txt
> +++ 2.6-mm/Documentation/kernel-parameters.txt
> @@ -48,6 +48,7 @@ parameter is applicable:
>  	ISAPNP	ISA PnP code is enabled.
>  	ISDN	Appropriate ISDN support is enabled.
>  	JOY	Appropriate joystick support is enabled.
> +	LIBATA  Libata driver is enabled
>  	LP	Printer support is enabled.
>  	LOOP	Loopback device support is enabled.
>  	M68k	M68k architecture is enabled.
> @@ -1013,6 +1014,10 @@ and is between 256 and 4096 characters. 
>  			emulation library even if a 387 maths coprocessor
>  			is present.
>  
> +	noacpi		[LIBATA] Disables use of ACPI in libata suspend/resume
> +			when set.
> +			Format: <int>

this will confuse users that already think they can disable ACPI with "noacpi"
(instead of "acpi=off") and that already fight with "noapic". I have seen too
many confusions of this kind in bugreports.

Couldn't it be made "libata=noacpi" like we have "pci=noacpi" already?
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
