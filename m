Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWGLRVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWGLRVE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWGLRVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:21:04 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:19402 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932138AbWGLRVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:21:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ersR+9tF15JFLLAtCXL3l2CxC+3VrtUiBTZbI7Kd8qMjAerS0Ze0NoaDCilQSXWhF/dZG+MhEdlJAESY+ayISR7KABWRLzdd9XfRkipPQ6sKEEG2lHGwoFxVigYVMSWRscKPFDCAFArFrDB/fG6x5PQdQXgGW6vR9JxwXE9G1lQ=
Message-ID: <44B52F84.1090003@gmail.com>
Date: Wed, 12 Jul 2006 11:21:08 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [ patch -mm1 02/03 ] gpio: cosmetics - remove needless newlines
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2 - pure cosmetics - lose needless newlines.

3 - rename EXPORTed  gpio vtables  from {scx200,pc8736x}_access to  
_gpio_ops
new name is much closer to the vtable-name struct nsc_gpio_ops, should 
be clearer.
Also rename the _fops vtable var to _fileops to better disambiguate it 
from the gpio vtable.

Signed-off-by  Jim Cromie  <jim.cromie@gmail.com>

---

$ diffstat diff.cosmetic-1
 nsc_gpio.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


diff -ruNp -X dontdiff -X exclude-diffs a0-nohilo/drivers/char/nsc_gpio.c a0-1-cosmetic/drivers/char/nsc_gpio.c
--- a0-nohilo/drivers/char/nsc_gpio.c	2006-07-12 09:18:19.000000000 -0600
+++ a0-1-cosmetic/drivers/char/nsc_gpio.c	2006-07-12 10:27:46.000000000 -0600
@@ -68,13 +68,11 @@ ssize_t nsc_gpio_write(struct file *file
 			amp->gpio_config(m, ~1, 0);
 			break;
 		case 'T':
-			dev_dbg(dev, "GPIO%d output is push pull\n",
-			       m);
+			dev_dbg(dev, "GPIO%d output is push pull\n", m);
 			amp->gpio_config(m, ~2, 2);
 			break;
 		case 't':
-			dev_dbg(dev, "GPIO%d output is open drain\n",
-			       m);
+			dev_dbg(dev, "GPIO%d output is open drain\n", m);
 			amp->gpio_config(m, ~2, 0);
 			break;
 		case 'P':


