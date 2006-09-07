Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751658AbWIGLIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbWIGLIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 07:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWIGLIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 07:08:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:24218 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751652AbWIGLIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 07:08:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=I2Pcgme4TWGXWm3+5MdJnBWTqZg6hecq6YG5POs2TLhvCgLRLvTz3GRYa7uNhDSYiMpFiekrC6QIwdtES48ZF2clb16MsHV306tO7iW0DKRBM8tVFUQBIO1MpiYxXgyt0XOxYgCmfRRhBGP1VCeZPnx+Dzg3CviOmfNGcqBCHJc=
Date: Thu, 7 Sep 2006 15:08:46 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [PATCH] optical /proc/ide/*/media
Message-ID: <20060907110846.GB5470@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov reported that his "FUJITSU MCC3064AP, ATAPI OPTICAL drive"
pops up as UNKNOWN in /proc/ide/*/media .

Closes #4145.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/ide/ide-proc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -376,6 +376,8 @@ static int proc_ide_read_media
 				break;
 		case ide_floppy:media = "floppy\n";
 				break;
+		case ide_optical:media = "optical\n";
+				break;
 		default:	media = "UNKNOWN\n";
 				break;
 	}

