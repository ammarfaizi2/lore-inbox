Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276215AbRJKQgb>; Thu, 11 Oct 2001 12:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276545AbRJKQgX>; Thu, 11 Oct 2001 12:36:23 -0400
Received: from transfire.txc.com ([208.5.237.254]:29618 "EHLO pguin2.txc.com")
	by vger.kernel.org with ESMTP id <S276535AbRJKQgM>;
	Thu, 11 Oct 2001 12:36:12 -0400
Subject: parport ieee1284 patch
From: Dmitriy Zavin <dzavin@txc.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 11 Oct 2001 12:42:29 -0400
Message-Id: <1002818550.1239.2.camel@nebula>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi gang,

I tried to compile 2.4.12 today and got some compile errors... seems
that someone forgot to put ECP in IEEE1284_PH_DIR_UNKNOWN (something
like that)

I am including the patch.. (2 lines long or so)

--Dima

PATCH_STARTS_HERE:
~~~~~~~~~~~~~~~~~~

--- linux-2.4.12/drivers/parport/ieee1284_ops.c.old	Thu Oct 11 12:16:23 2001
+++ linux-2.4.12/drivers/parport/ieee1284_ops.c	Thu Oct 11 12:16:44 2001
@@ -362,7 +362,7 @@
 	} else {
 		DPRINTK (KERN_DEBUG "%s: ECP direction: failed to reverse\n",
 			 port->name);
-		port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+		port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
 	}
 
 	return retval;
@@ -394,7 +394,7 @@
 		DPRINTK (KERN_DEBUG
 			 "%s: ECP direction: failed to switch forward\n",
 			 port->name);
-		port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+		port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
 	}

~~~~~~~~~~~~
END_OF_PATCH 



-- 


---------------------------------------------------------------------
 /#######/                     ###           @@  ##         $$
    $$   ## ##  $$$ $  ## ##  #   * $$   $$      $$   ###%  ##
    ##   $$$   ##  ##  $$$  $ .##   ##   ##  $$ #### $$   # $$$$%
    $$   ##    $$  $$  ##   #   ##. $$ @ $$  ##  $$  ##     ##  ##
    ##   $$    ##  ##  $$   % ,   # ## @ ##  $$  ##  $$   # $$  ##
    $$   ##     $$$ $$ $$   @  ###   $$ $$   &*  $$   ###%  ##  ##

 ___________________________________________________________________
/       Dmitriy Zavin          |  92 Montvale Avenue, Suite 3500    \
\  Member Technical Staff      |  Stoneham, MA 02180                /
/    Software Engineer         |  Phone: 781-438-1479 ext. 3344     \
\                              |  Fax:                              /
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

