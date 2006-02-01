Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWBANMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWBANMF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWBANMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:12:05 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:55116 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964955AbWBANME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:12:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=fVOHIVUObaXLBZ4uIcqg17gwCXizRFHRm525NRKRUCub9vGEIxHu4r+hdNm8qXN9TSGruAjaV0jRx7hPnrp5YGy6fFBRmRRvR2GuBaJ8+wKchQZHTxnUAtyJm1d/2/fg3JksP0jkPrqCpqEVHUuR7XSv5NYPwpSK4YnAEj31HMU=
Date: Wed, 1 Feb 2006 16:30:15 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] extract-ikconfig: don't use --long-options
Message-ID: <20060201133014.GA3620@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 scripts/extract-ikconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/extract-ikconfig
+++ b/scripts/extract-ikconfig
@@ -21,7 +22,7 @@ function dump_config {
     let start="$start + 8"
     let size="$end - $start"
 
-    head --bytes="$end" "$file" | tail --bytes="$size" | zcat
+    dd if="$file" ibs=1 skip="$start" count="$size" 2>/dev/null | zcat
 
     clean_up
     exit 0

