Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268999AbUI2Uq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268999AbUI2Uq6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 16:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269026AbUI2Uqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 16:46:54 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:38626 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S268999AbUI2UqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 16:46:00 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: Bernd Schubert <bernd-schubert@web.de>
Subject: Re: 2.6.9-rc2: isofs oops
Date: Wed, 29 Sep 2004 22:45:58 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200409292008.17149.bernd-schubert@web.de>
In-Reply-To: <200409292008.17149.bernd-schubert@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409292245.58857.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Schubert wrote:
>
> ISO 9660 Extensions: RRIP_1991A
[oops in isofs]


Known and already fixed by Andrew Morton.

--- a/fs/isofs/rock.c   2004-09-29 13:45:15 -07:00
+++ b/fs/isofs/rock.c   2004-09-29 13:45:15 -07:00
@@ -62,7 +62,7 @@
 }                                     
 
 #define MAYBE_CONTINUE(LABEL,DEV) \
-  {if (buffer) kfree(buffer); \
+  {if (buffer) { kfree(buffer); buffer = NULL; } \
   if (cont_extent){ \
     int block, offset, offset1; \
     struct buffer_head * pbh; \


cheers

Christian

