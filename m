Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276631AbRJKRoH>; Thu, 11 Oct 2001 13:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276634AbRJKRn6>; Thu, 11 Oct 2001 13:43:58 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:28447 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S276633AbRJKRnv>; Thu, 11 Oct 2001 13:43:51 -0400
Subject: Re: Kernel 2.4.12 Compiling error.
From: Robert Love <rml@tech9.net>
To: Malcolm Mallardi <magamo@mirkwood.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011011132003.A13730@trianna.upcommand.net>
In-Reply-To: <20011011132003.A13730@trianna.upcommand.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 11 Oct 2001 13:44:13 -0400
Message-Id: <1002822259.864.34.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-10-11 at 13:20, Malcolm Mallardi wrote:
> In the new Kernel 2.4.12, when attempting to compile modules, the parport 
> module dies, I'm attempting to compile it with IEEE1284 readback support 
> (HP OJ T45 printer)

This patch fixes:

--- ieee1284_ops.c~     Thu Oct 11 11:10:37 2001
+++ ieee1284_ops.c      Thu Oct 11 11:22:31 2001
@@ -362,7 +362,7 @@
        } else {
                DPRINTK (KERN_DEBUG "%s: ECP direction: failed to reverse\n",
                         port->name);
-               port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+               port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
        }

        return retval;
@@ -394,7 +394,7 @@
                DPRINTK (KERN_DEBUG
                         "%s: ECP direction: failed to switch forward\n",
                         port->name);
-               port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+               port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
        }



	Robert Love

