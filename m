Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132314AbRAHVam>; Mon, 8 Jan 2001 16:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132560AbRAHVaW>; Mon, 8 Jan 2001 16:30:22 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:62990 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S132314AbRAHVaP>; Mon, 8 Jan 2001 16:30:15 -0500
Date: Mon, 8 Jan 2001 22:25:35 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Giacomo Catenazzi <cate@student.ethz.ch>
Cc: "J . A . Magallon" <jamagallon@able.es>,
        "Giacomo A . Catenazzi" <cate@dplanet.ch>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Coppermine is a PIII or a Celeron?
Message-ID: <20010108222535.A3472@arthur.ubicom.tudelft.nl>
In-Reply-To: <fa.dl37erv.6j04hb@ifi.uio.no> <fa.hcv7gqv.s3k9qk@ifi.uio.no> <3A5991BC.64525AF7@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5991BC.64525AF7@student.ethz.ch>; from cate@student.ethz.ch on Mon, Jan 08, 2001 at 11:09:00AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 11:09:00AM +0100, Giacomo Catenazzi wrote:
> Thus the older Celerons should be compiled with CONFIG_M686 (Pentium
> Pro),
> but the Celeron Coppermine can be compiled with CONFIG_M686FXSR (Pentium
> III), right?

Yes.

> In this case we should update the files Configure.help and the config.in
> files.

I supplied a patch which did that, but Linus dropped all patches (on
purpose). Here it is again:

Index: Documentation/Configure.help
===================================================================
RCS file: /home/erik/cvsroot/elinux/Documentation/Configure.help,v
retrieving revision 1.1.1.57
diff -u -r1.1.1.57 Configure.help
--- Documentation/Configure.help	2000/12/13 15:10:53	1.1.1.57
+++ Documentation/Configure.help	2000/12/23 22:58:12
@@ -2868,7 +2868,7 @@
    - "Pentium-Classic" for the Intel Pentium.
    - "Pentium-MMX" for the Intel Pentium MMX.
    - "Pentium-Pro" for the Intel Pentium Pro/Celeron/Pentium II.
-   - "Pentium-III" for the Intel Pentium III.
+   - "Pentium-III" for the Intel Pentium III/Celeron Coppermine.
    - "Pentium-4" for the Intel Pentium 4
    - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
    - "Athlon" for the AMD Athlon (K7).
Index: arch/i386/config.in
===================================================================
RCS file: /home/erik/cvsroot/elinux/arch/i386/config.in,v
retrieving revision 1.1.1.13
diff -u -r1.1.1.13 config.in
--- arch/i386/config.in	2000/12/13 15:09:15	1.1.1.13
+++ arch/i386/config.in	2000/12/23 23:12:55
@@ -33,7 +33,7 @@
 	 Pentium-Classic		CONFIG_M586TSC \
 	 Pentium-MMX			CONFIG_M586MMX \
 	 Pentium-Pro/Celeron/Pentium-II	CONFIG_M686 \
-	 Pentium-III			CONFIG_M686FXSR \
+	 Pentium-III/Celeron Coppermine	CONFIG_M686FXSR \
 	 Pentium-4			CONFIG_MPENTIUM4 \
 	 K6/K6-II/K6-III		CONFIG_MK6 \
 	 Athlon/K7			CONFIG_MK7 \


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
