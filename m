Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWF2NL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWF2NL4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 09:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWF2NL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 09:11:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:37545 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750742AbWF2NLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 09:11:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=hp61ILKQ193grfVf5pOUAcI3MsQv1K3CXCPRyaHa3EcVjh1wmMDdxSaK0uQ6OBpDePmy/Ph40BhUMK8DEm7AqK9sJvQCtEJCNY0RP/cbr/sC4NE6eDJ9XeeS8lTuqDuZ22NwVVd527XHV5EsL3wKVouLvLU5Sde4ILJcfvl8nUs=
Date: Thu, 29 Jun 2006 15:11:55 +0200
From: Paolo Ornati <ornati@gmail.com>
To: Paolo Ornati <ornati@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org, Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       jensmh@gmx.de
Subject: Re: [PATCH] Documentation: remove duplicate cleanups
Message-ID: <20060629151155.5609d59f@localhost>
In-Reply-To: <20060629134002.1b06257c@localhost>
References: <20060629134002.1b06257c@localhost>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 13:40:02 +0200
Paolo Ornati <ornati@gmail.com> wrote:

> Remove every (hopefully) duplicated word under Documentation/.
> 
> Examples:
> 	"and and" --> "and"
> 	"in in" --> "in"
> 	...

I've re-read the whole thing and found these, please comment:

--------
diff --git a/Documentation/DocBook/videobook.tmpl b/Documentation/DocBook/videobook.tmpl
index fdff984..d19ccee 100644
--- a/Documentation/DocBook/videobook.tmpl
+++ b/Documentation/DocBook/videobook.tmpl
@@ -322,7 +322,7 @@ static int radio_ioctl(struct video_devi
                                </entry>
        </row><row>
         <entry>type</entry><entry>This reports the capabilities of the device, and
-                        matches the field we filled in in the struct
+                        matches the field we filled in the struct
                         video_device when registering.</entry>
------------

I'm not 100% sure of this.


-----------------
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 0d189c9..9adc500 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -106,7 +106,7 @@ Do not modify the syntax of boot loader
 need or coordination with <Documentation/i386/boot.txt>.

 Note that ALL kernel parameters listed below are CASE SENSITIVE, and that
-a trailing = on the name of any parameter states that that parameter will
+a trailing = on the name of any parameter states that parameter will
 be entered as an environment variable, whereas its absence indicates that
 it will appear as a kernel argument readable via /proc/cmdline by programs
 running once the system is up.
-------------------------------

The old one looks correct.



---------------------------------------------
 Life isn't quite as simple as it may appear above, however: for while the
-caches are expected to be coherent, there's no guarantee that that coherency
+caches are expected to be coherent, there's no guarantee that coherency
 will be ordered.  This means that whilst changes made on one CPU will
 eventually become visible on all CPUs, there's no guarantee that they will
 become apparent in the same order on those other CPUs.
---------------------------------------------------

Not sure.


-----------------------------------------
--- a/Documentation/networking/pt.txt
+++ b/Documentation/networking/pt.txt
@@ -25,7 +25,7 @@ recompile it.

 The driver is not real good at the moment for finding the card.  You can
 'help' it by changing the order of the potential addresses in the structure
-found in the pt_init() function so the address of where the card is is put
+found in the pt_init() function so the address of where the card is put
 first.
------------------------------------------

The old one looks correct.

-- 
	Paolo Ornati
	Linux 2.6.17.1 on x86_64
