Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292170AbSBOVpv>; Fri, 15 Feb 2002 16:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292178AbSBOVpm>; Fri, 15 Feb 2002 16:45:42 -0500
Received: from mg02.austin.ibm.com ([192.35.232.12]:47058 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S292170AbSBOVpa>; Fri, 15 Feb 2002 16:45:30 -0500
Date: Fri, 15 Feb 2002 15:44:45 -0600 (CST)
From: Kent Yoder <key@austin.ibm.com>
To: <jgarzik@mandrakesoft.com>
cc: <linux-kernel@vger.kernel.org>, <marcelo@conectiva.com.br>
Subject: [PATCH] IBM Lanstreamer bugfixes (round 3)
Message-ID: <Pine.LNX.4.33.0202151541110.4625-101000@janetreno.austin.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="889843928-611533043-1012842992=:12677"
Content-ID: <Pine.LNX.4.33.0202151541111.4625@janetreno.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--889843928-611533043-1012842992=:12677
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0202151541112.4625@janetreno.austin.ibm.com>


Second try..  :-)

  When and if this passes code inspection, it should be included in 2.4 and 
2.5.  

Thanks,
Kent

-------------

 Sorry, in round 2 I neglected to #include version.h.  Please ignore round 
2.

  Below is the old changelog, with this now added:

 * #include linux/version.h for in-kernel support

--------------

  Changes made:

 * No more magic numbers, all come from pci.h
 * no more udelay()'s, which covered up PCI posting effects
 * got rid of a __u8/__u16 here and there for u8/u16
 * ioctl code disabled for kernel >= 2.5 (now with version.h, too!)
 * bounded the number of times we could loop inside the interrupt function
 * spin_lock_irqsave/restore in open()/close()
 * better formatting

Thanks,
Kent

--889843928-611533043-1012842992=:12677
Content-Type: APPLICATION/X-GZIP; NAME="lanstreamer-0.5.2.patch.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0202041116320.12677@janetreno.austin.ibm.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="lanstreamer-0.5.2.patch.gz"

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
CVlo+i1w4Fv/ZaXQg/8B4hcf3NpCAAA=
--889843928-611533043-1012842992=:12677--
