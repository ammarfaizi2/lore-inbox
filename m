Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316220AbSEKNqj>; Sat, 11 May 2002 09:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316221AbSEKNqi>; Sat, 11 May 2002 09:46:38 -0400
Received: from CPE-203-51-25-114.nsw.bigpond.net.au ([203.51.25.114]:26612
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S316220AbSEKNqi>; Sat, 11 May 2002 09:46:38 -0400
Message-ID: <3CDD20B9.471668FE@eyal.emu.id.au>
Date: Sat, 11 May 2002 23:46:33 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8-aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: 2.4.19-pre8 drivers/char/Config.in fix
Content-Type: multipart/mixed;
 boundary="------------41639B0EAB38435AF4587D8B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------41639B0EAB38435AF4587D8B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I deselected CONFIG_AGP_HP_ZX1 manually when it was broken
a while back, and I now see that it is still not fixed.
A trivial fix but still necessary.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------41639B0EAB38435AF4587D8B
Content-Type: text/plain; charset=us-ascii;
 name="2.4.19-pre8-char.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.19-pre8-char.patch"

*** linux/drivers/char/Config.in.orig	Sat May 11 23:36:20 2002
--- linux/drivers/char/Config.in	Sat May 11 23:37:35 2002
***************
*** 260,266 ****
     bool '  Generic SiS support' CONFIG_AGP_SIS
     bool '  ALI chipset support' CONFIG_AGP_ALI
     bool '  Serverworks LE/HE support' CONFIG_AGP_SWORKS
!    dep_bool '  HP ZX1 AGP support' CONFIG_AGP_HP_ZX1 $CONFIG_IA64
  fi
  
  bool 'Direct Rendering Manager (XFree86 DRI support)' CONFIG_DRM
--- 260,268 ----
     bool '  Generic SiS support' CONFIG_AGP_SIS
     bool '  ALI chipset support' CONFIG_AGP_ALI
     bool '  Serverworks LE/HE support' CONFIG_AGP_SWORKS
!    if [ "$CONFIG_IA64" = "y" ]; then
!       bool '  HP ZX1 AGP support' CONFIG_AGP_HP_ZX1
!    fi
  fi
  
  bool 'Direct Rendering Manager (XFree86 DRI support)' CONFIG_DRM

--------------41639B0EAB38435AF4587D8B--

