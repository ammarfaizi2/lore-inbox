Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262748AbREONOB>; Tue, 15 May 2001 09:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262749AbREONNv>; Tue, 15 May 2001 09:13:51 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:50949 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S262748AbREONNg>; Tue, 15 May 2001 09:13:36 -0400
Date: Tue, 15 May 2001 15:13:17 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] fix menuconfig
Message-ID: <20010515151317.D25153@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This minor fix from Alan's -ac tree fixes the "make menuconfig" problem
in linux-2.4.5-pre[12]. The problem was that with the new
"Pentium-III/Celeron(Coppermine)" choice in arch/i386/config.in
menuconfig broke on the '()' in a choice. Please apply.


Erik

Index: scripts/Menuconfig
===================================================================
RCS file: /home/erik/cvsroot/elinux/scripts/Menuconfig,v
retrieving revision 1.1.1.11
retrieving revision 1.1.1.12
diff -u -r1.1.1.11 -r1.1.1.12
--- scripts/Menuconfig	2001/05/15 11:40:54	1.1.1.11
+++ scripts/Menuconfig	2001/05/15 12:28:57	1.1.1.12
@@ -347,7 +347,7 @@
 
 	echo -e "
 	function $firstchoice () \
-		{ l_choice '$title' \"$choices\" $current ;}" >>MCradiolists
+		{ l_choice '$title' \"$choices\" \"$current\" ;}" >>MCradiolists
 }
 
 } # END load_functions()


-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
