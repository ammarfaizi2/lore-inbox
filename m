Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161731AbWKHWJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161731AbWKHWJa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161735AbWKHWJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:09:30 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:53791 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161733AbWKHWJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:09:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=EWCezwcFXLt5dwcDGViWxembLUeWt4gSWj1seNLDci5gDw8lXMjw7GYkvWU8AGdT6vKGW57FKNrsLcSQGS82u6IjtCqraSfPSAFgB5wAYrIuTEWERLpd+jbDElc6m7+BmzgN8OytiNzitYWvAK48H+1d+vsfUW1inUsDH0XitHA=
Date: Thu, 9 Nov 2006 01:09:25 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Corey Minyard <minyard@acm.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi_si_intf.c: fix "&& 0xff" typos
Message-ID: <20061108220925.GB4972@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/char/ipmi/ipmi_si_intf.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1211,7 +1211,7 @@ static void intf_mem_outb(struct si_sm_i
 static unsigned char intf_mem_inw(struct si_sm_io *io, unsigned int offset)
 {
 	return (readw((io->addr)+(offset * io->regspacing)) >> io->regshift)
-		&& 0xff;
+		& 0xff;
 }
 
 static void intf_mem_outw(struct si_sm_io *io, unsigned int offset,
@@ -1223,7 +1223,7 @@ static void intf_mem_outw(struct si_sm_i
 static unsigned char intf_mem_inl(struct si_sm_io *io, unsigned int offset)
 {
 	return (readl((io->addr)+(offset * io->regspacing)) >> io->regshift)
-		&& 0xff;
+		& 0xff;
 }
 
 static void intf_mem_outl(struct si_sm_io *io, unsigned int offset,
@@ -1236,7 +1236,7 @@ #ifdef readq
 static unsigned char mem_inq(struct si_sm_io *io, unsigned int offset)
 {
 	return (readq((io->addr)+(offset * io->regspacing)) >> io->regshift)
-		&& 0xff;
+		& 0xff;
 }
 
 static void mem_outq(struct si_sm_io *io, unsigned int offset,

