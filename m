Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136374AbRD2VRe>; Sun, 29 Apr 2001 17:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136375AbRD2VRZ>; Sun, 29 Apr 2001 17:17:25 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:28179 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S136374AbRD2VRQ>; Sun, 29 Apr 2001 17:17:16 -0400
Date: Sun, 29 Apr 2001 23:13:12 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
Cc: Duncan Gauld <duncan@gauldd.freeserve.co.uk>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: Re: question regarding cpu selection
Message-ID: <20010429231312.I24579@arthur.ubicom.tudelft.nl>
In-Reply-To: <01042919075101.01335@pc-62-31-91-135-dn.blueyonder.co.uk> <20010429145608.A703@better.net> <20010429223641.K3529@niksula.cs.hut.fi> <01042921284803.01335@pc-62-31-91-135-dn.blueyonder.co.uk> <20010429233250.G3682@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010429233250.G3682@niksula.cs.hut.fi>; from vherva@mail.niksula.cs.hut.fi on Sun, Apr 29, 2001 at 11:32:51PM +0300
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 11:32:51PM +0300, Ville Herva wrote:
> On Sun, Apr 29, 2001 at 09:28:48PM -0400, you [Duncan Gauld] claimed:
> > I would supply a patch, but I don't know how to write such a thing :)
> 
> It seems Erik Mouw already submitted a patch, altough I agree that "Celeron
> II" might be a better name for the thing than "Celeron (Coppermine)".

So what about this one? This time I had to change Configure.help and
setup.c as well to reflect the changes in config.in :)


Erik

Index: arch/i386/config.in
===================================================================
RCS file: /home/erik/cvsroot/elinux/arch/i386/config.in,v
retrieving revision 1.1.1.38
diff -u -r1.1.1.38 config.in
--- arch/i386/config.in	2001/04/26 12:31:41	1.1.1.38
+++ arch/i386/config.in	2001/04/29 20:52:43
@@ -33,7 +33,7 @@
 	 Pentium-Classic		CONFIG_M586TSC \
 	 Pentium-MMX			CONFIG_M586MMX \
 	 Pentium-Pro/Celeron/Pentium-II	CONFIG_M686 \
-	 Pentium-III			CONFIG_MPENTIUMIII \
+	 Pentium-III/Celeron II		CONFIG_MPENTIUMIII \
 	 Pentium-4			CONFIG_MPENTIUM4 \
 	 K6/K6-II/K6-III		CONFIG_MK6 \
 	 Athlon/Duron/K7		CONFIG_MK7 \
Index: arch/i386/kernel/setup.c
===================================================================
RCS file: /home/erik/cvsroot/elinux/arch/i386/kernel/setup.c,v
retrieving revision 1.1.1.51
diff -u -r1.1.1.51 setup.c
--- arch/i386/kernel/setup.c	2001/04/28 13:24:25	1.1.1.51
+++ arch/i386/kernel/setup.c	2001/04/29 21:01:10
@@ -1841,7 +1841,7 @@
 			
 		case 8:
 			if (l2 == 128)
-				p = "Celeron (Coppermine)";
+				p = "Celeron II (Coppermine)";
 			break;
 		}
 	}
Index: Documentation/Configure.help
===================================================================
RCS file: /home/erik/cvsroot/elinux/Documentation/Configure.help,v
retrieving revision 1.1.1.108
diff -u -r1.1.1.108 Configure.help
--- Documentation/Configure.help	2001/04/26 12:44:35	1.1.1.108
+++ Documentation/Configure.help	2001/04/29 20:53:32
@@ -3033,7 +3033,7 @@
    - "Pentium-MMX" for the Intel Pentium MMX.
    - "Pentium-Pro" for the Intel Pentium Pro/Celeron/Pentium II.
    - "Pentium-III" for the Intel Pentium III
-     and Celerons based on the coppermine core.
+     and Celerons based on the coppermine core (Celeron II).
    - "Pentium-4" for the Intel Pentium 4.
    - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
    - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
