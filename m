Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313016AbSDTWOl>; Sat, 20 Apr 2002 18:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSDTWOk>; Sat, 20 Apr 2002 18:14:40 -0400
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:39694 "EHLO
	mail.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S313016AbSDTWOj>; Sat, 20 Apr 2002 18:14:39 -0400
Date: Sat, 20 Apr 2002 16:14:34 -0600 (MDT)
From: James Bourne <jbourne@MtRoyal.AB.CA>
Subject: [PATCH] (Correction) 2.4.18 model 0x02 CPU for family 0x0F
To: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.44.0204201607580.18397-200000@skuld.mtroyal.ab.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_xLTKD5Ft7sbA4l3+UH9fpg)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary_(ID_xLTKD5Ft7sbA4l3+UH9fpg)
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT

Thanks to Jeff Nguyen for pointing out this error.  The P4 XEON processors
are orficially referred to as XEON processors by Intel.  

Patch adds the ident of model 0x02 to family 0x0F.

A rose by any other name..

Regards,
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



--Boundary_(ID_xLTKD5Ft7sbA4l3+UH9fpg)
Content-id: <Pine.LNX.4.44.0204201614340.18397@skuld.mtroyal.ab.ca>
Content-type: TEXT/PLAIN; name=2.4.18-xeon-ident.patch; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=2.4.18-xeon-ident.patch
Content-description: 

--- linux-2.4.18/arch/i386/kernel/mpparse.c~	Sat Apr 20 15:59:10 2002
+++ linux-2.4.18/arch/i386/kernel/mpparse.c	Sat Apr 20 16:03:10 2002
@@ -113,6 +113,8 @@
 		case 0x0F:
 			if (model == 0x00)
 				return("Pentium 4(tm)");
+			if (model == 0x02)
+				return("XEON(tm)");
 			if (model == 0x0F)
 				return("Special controller");
 	}

--Boundary_(ID_xLTKD5Ft7sbA4l3+UH9fpg)--
