Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267394AbTAWXkN>; Thu, 23 Jan 2003 18:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbTAWXkN>; Thu, 23 Jan 2003 18:40:13 -0500
Received: from bilmuh.ege.edu.tr ([155.223.24.250]:51111 "EHLO
	bilmuh.ege.edu.tr") by vger.kernel.org with ESMTP
	id <S267394AbTAWXkL>; Thu, 23 Jan 2003 18:40:11 -0500
Date: Fri, 24 Jan 2003 02:10:05 +0200
From: Halil Demirezen <nitrium@bilmuh.ege.edu.tr>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI update (20030122)
Message-ID: <20030124001005.GA8442@bilmuh.ege.edu.tr>
References: <F760B14C9561B941B89469F59BA3A84725A131@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A131@orsmsx401.jf.intel.com>
User-Agent: Mutt/1.3.28i
X-URL: http://www.pisus.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That seems that you've rewritten the acpi.c :)




On Thu, Jan 23, 2003 at 02:44:55PM -0800, Grover, Andrew wrote:
> Hi all,
> 
> The latest ACPI patch is now available at http://sf.net/projects/acpi .
> Non-Linux packages will be available within 24 hours from
> http://developer.intel.com/technology/iapc/acpi/downloads.htm .
> 
> The patches are big primarily because we finally got with the program
> and moved our headers from drivers/acpi/include to include/acpi.
> 
> Regards -- Andy
> 
> 22 January 2003.  Summary of changes for version 20030122.
> 
> 
> 1) ACPI CA Core Subsystem:
> 
> Added a check for constructs of the form:  Store (Local0,
> Local0) where Local0 is not initialized.  Apparently, some
> BIOS programmers believe that this is a NOOP.  Since this
> store doesn't do anything anyway, the new prototype behavior
> will ignore this error.  This is a case where we can relax the
> strict checking in the interpreter in the name of
> compatibility.
> 
> 
> 2) Linux
> 
> The AcpiSrc Source Conversion Utility has been released with
> the Unix package for the first time.  This is the utility
> that is used to convert the ACPI CA base source code to the
> Linux version.
> 
> (Both) Handle P_BLK lengths shorter than 6 more gracefully
> 
> (Both) Move more headers to include/acpi, and delete an unused
> header.
> 
> (Both) Move drivers/acpi/include directory to include/acpi
> 
> (Both) Boot functions don't use cmdline, so don't pass it
> around
> 
> (Both) Remove include of unused header (Adrian Bunk)
> 
> (Both) acpiphp.h includes both linux/acpi.h and acpi_bus.h.
> Since the former now also includes the latter, acpiphp.h only needs the
> one, now.
> 
> (2.5) Make it possible to select method of bios restoring
> after S3 resume. [=> no more ugly ifdefs] (Pavel Machek)
> 
> (2.5) Make proc write interfaces work (Pavel Machek)
> 
> (2.5) Properly init/clean up in cpufreq/acpi (Dominik
> Brodowski)
> 
> (2.5) Break out ACPI Perf code into its own module, under
> cpufreq (Dominik Brodowski)
> 
> (2.4) S4BIOS support (Ducrot Bruno)
> 
> (2.4) Fix acpiphp_glue.c for latest ACPI struct changes
> (Sergio Visinoni)
> 
> 
> 3) iASL Compiler:
> 
> Added support to disassemble SSDT and PSDTs.
> 
> Implemented support to obtain SSDTs from the Windows registry
> if available.
> 
> -----------------------------
> Andrew Grover
> Intel Labs / Mobile Architecture
> andrew.grover@intel.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
