Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314211AbSDRBhk>; Wed, 17 Apr 2002 21:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314212AbSDRBhj>; Wed, 17 Apr 2002 21:37:39 -0400
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:36878 "EHLO
	mail.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S314211AbSDRBhi>; Wed, 17 Apr 2002 21:37:38 -0400
Date: Wed, 17 Apr 2002 19:37:33 -0600 (MDT)
From: James Bourne <jbourne@MtRoyal.AB.CA>
Subject: [PATCH] 2.4.18 model 0x02 CPU for family 0x0F
To: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.44.0204171934500.28706-200000@skuld.mtroyal.ab.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_rLO3d3onuT0mzpGAOEZfag)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary_(ID_rLO3d3onuT0mzpGAOEZfag)
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT

Hi
This is a simple patch to mpparse.c which will identify the P4-X CPU on
boot (instead of coming up with Unknown CPU [15/2]).

It is against 2.4.18, but should apply to the 2.4.19-pre kernels.

Regards
James Bourne

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************

--Boundary_(ID_rLO3d3onuT0mzpGAOEZfag)
Content-id: <Pine.LNX.4.44.0204171937330.28706@skuld.mtroyal.ab.ca>
Content-type: TEXT/PLAIN; name=2.4.18-p4-xeon-ident.patch; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=2.4.18-p4-xeon-ident.patch
Content-description: patch

--- linux-2.4.18/arch/i386/kernel/mpparse.c~	Fri Nov  9 15:58:18 2001
+++ linux-2.4.18/arch/i386/kernel/mpparse.c	Wed Apr 17 12:57:08 2002
@@ -113,6 +113,8 @@
 		case 0x0F:
 			if (model == 0x00)
 				return("Pentium 4(tm)");
+			if (model == 0x02)
+				return("Pentium 4(tm) XEON(tm)");
 			if (model == 0x0F)
 				return("Special controller");
 	}

--Boundary_(ID_rLO3d3onuT0mzpGAOEZfag)--
