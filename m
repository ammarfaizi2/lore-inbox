Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161045AbWBAMiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbWBAMiw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbWBAMiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:38:50 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:8407 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161035AbWBAMis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:38:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=ZGHq9ISOyIVbqyUFtNINOR65+Ur+PO3swYBaRxMGTOg3DBaIttXrMoSbsxIMtgiMV5AierCYD+3Rx8yimsVFlGWaCyvbVbWsHqgfWqaUHfRm/ZQd2RzNMSRPADaKl1uoardJsWZJ8lXW0oD1EuXd0vu3hG19JC2FlVyw2YuRzvI=
Date: Wed, 1 Feb 2006 15:56:58 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] extract-ikconfig: be sure binoffset exists before extracting
Message-ID: <20060201125658.GB8943@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 scripts/extract-ikconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/scripts/extract-ikconfig
+++ b/scripts/extract-ikconfig
@@ -4,6 +4,7 @@
 # $arg1 is [b]zImage filename
 
 binoffset="./scripts/binoffset"
+test -e $binoffset || cc -o $binoffset ./scripts/binoffset.c || exit 1
 
 IKCFG_ST="0x49 0x4b 0x43 0x46 0x47 0x5f 0x53 0x54"
 IKCFG_ED="0x49 0x4b 0x43 0x46 0x47 0x5f 0x45 0x44"

