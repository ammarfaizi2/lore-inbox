Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129295AbQKWUpz>; Thu, 23 Nov 2000 15:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129586AbQKWUpp>; Thu, 23 Nov 2000 15:45:45 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:50604 "EHLO
        smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
        id <S129295AbQKWUpb>; Thu, 23 Nov 2000 15:45:31 -0500
Message-ID: <3A1D7ADD.8F243AA0@haque.net>
Date: Thu, 23 Nov 2000 15:15:25 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Phil Stracchino <alaric@babcom.com>
CC: Linux-KERNEL <linux-kernel@vger.kernel.org>, support@vmware.com
Subject: Re: VMWare will not run on kernel 2.4.0-test11
In-Reply-To: <20001123120701.A1338@babylon5.babcom.com>
Content-Type: multipart/mixed;
 boundary="------------E02D9A36ECED45007539BDEC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E02D9A36ECED45007539BDEC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Tiny patch for vmware-config.pl

Phil Stracchino wrote:
> 
> I just compiled and installed kernel 2.4.0-test11.  Upon rebooting,
> vmware-2.0.3-786 refused to run.  Running vmware-config.pl resulted in a
> the following message:
> 
>         "Your processor does not have a Time Stamp Counter. VMware will
>          not run on this system."
> 

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
--------------E02D9A36ECED45007539BDEC
Content-Type: text/plain; charset=us-ascii;
 name="vmware-config-2.4.0-test11.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vmware-config-2.4.0-test11.patch"

--- vmware-config.pl.old	Thu Nov 23 15:12:32 2000
+++ vmware-config.pl	Thu Nov 23 15:12:55 2000
@@ -1113,7 +1113,7 @@
   if (direct_command(shell_string($gHelper{'grep'}) . ' ' . shell_string('^cpuid') . ' /proc/cpuinfo') eq '') {
     error('Your ' . (($gSystem{'smp'} eq 'yes') ? 'processors do' : 'processor does') . ' not support the cpuid instruction. VMware will not run on this system.' . "\n\n");
   }
-  if (direct_command(shell_string($gHelper{'grep'}) . ' ' . shell_string('^flags.* tsc') . ' /proc/cpuinfo') eq '') {
+  if (direct_command(shell_string($gHelper{'grep'}) . ' ' . shell_string('^features.* tsc') . ' /proc/cpuinfo') eq '') {
     error('Your ' . (($gSystem{'smp'} eq 'yes') ? 'processors do' : 'processor does') . ' not have a Time Stamp Counter. VMware will not run on this system.' . "\n\n");
   }
 }

--------------E02D9A36ECED45007539BDEC--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
