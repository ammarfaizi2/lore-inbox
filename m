Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276977AbRJKWJj>; Thu, 11 Oct 2001 18:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276990AbRJKWJf>; Thu, 11 Oct 2001 18:09:35 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:50700 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S276977AbRJKWIe>; Thu, 11 Oct 2001 18:08:34 -0400
Subject: Re: [BUG] Linux-2.4.12 does not build.
From: Robert Love <rml@tech9.net>
To: Enver Haase <ehaase@inf.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10110112356310.8242-100000@haneman.hacenet>
In-Reply-To: <Pine.LNX.4.10.10110112356310.8242-100000@haneman.hacenet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 11 Oct 2001 18:09:01 -0400
Message-Id: <1002838143.870.14.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-10-11 at 17:58, Enver Haase wrote:
> ieee1284_ops.c:365: (Each undeclared identifier is reported only once
> ieee1284_ops.c:365: for each function it appears in.)
> ieee1284_ops.c: In function `ecp_reverse_to_forward':
> ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in

This is known.  Apply the attached patch.


--- ieee1284_ops.c~     Thu Oct 11 11:10:37 2001
+++ ieee1284_ops.c      Thu Oct 11 11:22:31 2001
@@ -362,7 +362,7 @@
        } else {
                DPRINTK (KERN_DEBUG "%s: ECP direction: failed to
reverse\n",
                         port->name);
-               port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+               port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
        }

        return retval;
@@ -394,7 +394,7 @@
                DPRINTK (KERN_DEBUG
                         "%s: ECP direction: failed to switch
forward\n",
                         port->name);
-               port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+               port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
        }


	Robert Love

