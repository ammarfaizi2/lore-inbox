Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279029AbRJVWxv>; Mon, 22 Oct 2001 18:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279050AbRJVWw4>; Mon, 22 Oct 2001 18:52:56 -0400
Received: from dspnet.claranet.fr ([212.43.196.92]:16914 "HELO
	dspnet.fr.eu.org") by vger.kernel.org with SMTP id <S279029AbRJVWvD>;
	Mon, 22 Oct 2001 18:51:03 -0400
Date: Tue, 23 Oct 2001 00:51:36 +0200
From: Jean-Luc Leger <reiga@dspnet.fr.eu.org>
To: linux-kernel@vger.kernel.org
Subject: preparsing mispellings in DRM and ATM header
Message-ID: <20011023005136.H3529@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some little bugs in preparsing code :
(Line numbers are all from 2.4.12-ac5 but seems to be the same for plain 2.4.12)

------------------------------------------------------------------ 
I tried to send this one to Rik Faith (faith@valinux.com)
but it seems he doesn't work there anymore ..
Maybe MAINTAINERS should be updated ^^;
 
The bug :
Line 39 of drivers/char/drm/ati_pcigart.h
-> Should be #else (and not #elif with nothing else on the line)
 
------------------------------------------------------------------- 
And an another one. Is there a maintainer for drivers/atm directory ?
 
The bug : 
Line 628 of drivers/atm/nicstar.h
#eliif (NS_LGBUFSIZE == 8192)
-> should be #elif
 
-------------------------------------------------------------------
And finaly, just for the purity of the code :

Line 2473 of drivers/sbus/char/aurora.c
#endif;
-> ';' seems useless

------------------------------------------------------------------
And one question : to whom should I send a patch for arch/ia64/sn 
subdir ? 

	JL Leger

