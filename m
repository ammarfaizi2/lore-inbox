Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136109AbRD2Tus>; Sun, 29 Apr 2001 15:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136122AbRD2Tu2>; Sun, 29 Apr 2001 15:50:28 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:60687 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S136109AbRD2TuU>; Sun, 29 Apr 2001 15:50:20 -0400
Date: Sun, 29 Apr 2001 21:41:53 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Duncan Gauld <duncan@gauldd.freeserve.co.uk>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        torvalds@transmeta.com
Subject: Re: question regarding cpu selection
Message-ID: <20010429214153.F24579@arthur.ubicom.tudelft.nl>
In-Reply-To: <01042919075101.01335@pc-62-31-91-135-dn.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01042919075101.01335@pc-62-31-91-135-dn.blueyonder.co.uk>; from duncan@gauldd.freeserve.co.uk on Sun, Apr 29, 2001 at 07:07:51PM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 07:07:51PM -0400, Duncan Gauld wrote:
> This seems a silly question but - I have an intel celeron 800mhz CPU and thus 
> it is of the Coppermine breed. But under cpu selection when configuring the 
> kernel, should I select PIII or PII/Celeron? Just wondering, since Coppermine 
> is basically a newish PIII with 128K less cache...

You should select PIII. Configure.help already says that, but here is a
patch against linux-2.4.4 that reflects that change in
arch/i386/config.in as well. Please apply.


Erik

Index: arch/i386/config.in
===================================================================
RCS file: /home/erik/cvsroot/elinux/arch/i386/config.in,v
retrieving revision 1.1.1.38
diff -u -r1.1.1.38 config.in
--- arch/i386/config.in	2001/04/26 12:31:41	1.1.1.38
+++ arch/i386/config.in	2001/04/29 19:28:12
@@ -27,21 +27,21 @@
 mainmenu_option next_comment
 comment 'Processor type and features'
 choice 'Processor family' \
-	"386				CONFIG_M386 \
-	 486				CONFIG_M486 \
-	 586/K5/5x86/6x86/6x86MX	CONFIG_M586 \
-	 Pentium-Classic		CONFIG_M586TSC \
-	 Pentium-MMX			CONFIG_M586MMX \
-	 Pentium-Pro/Celeron/Pentium-II	CONFIG_M686 \
-	 Pentium-III			CONFIG_MPENTIUMIII \
-	 Pentium-4			CONFIG_MPENTIUM4 \
-	 K6/K6-II/K6-III		CONFIG_MK6 \
-	 Athlon/Duron/K7		CONFIG_MK7 \
-	 Crusoe				CONFIG_MCRUSOE \
-	 Winchip-C6			CONFIG_MWINCHIPC6 \
-	 Winchip-2			CONFIG_MWINCHIP2 \
-	 Winchip-2A/Winchip-3		CONFIG_MWINCHIP3D \
-	 CyrixIII/C3			CONFIG_MCYRIXIII" Pentium-Pro
+	"386					CONFIG_M386 \
+	 486					CONFIG_M486 \
+	 586/K5/5x86/6x86/6x86MX		CONFIG_M586 \
+	 Pentium-Classic			CONFIG_M586TSC \
+	 Pentium-MMX				CONFIG_M586MMX \
+	 Pentium-Pro/Celeron/Pentium-II		CONFIG_M686 \
+	 Pentium-III/Celeron(Coppermine)	CONFIG_MPENTIUMIII \
+	 Pentium-4				CONFIG_MPENTIUM4 \
+	 K6/K6-II/K6-III			CONFIG_MK6 \
+	 Athlon/Duron/K7			CONFIG_MK7 \
+	 Crusoe					CONFIG_MCRUSOE \
+	 Winchip-C6				CONFIG_MWINCHIPC6 \
+	 Winchip-2				CONFIG_MWINCHIP2 \
+	 Winchip-2A/Winchip-3			CONFIG_MWINCHIP3D \
+	 CyrixIII/C3				CONFIG_MCYRIXIII" Pentium-Pro
 #
 # Define implied options from the CPU selection here
 #

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
