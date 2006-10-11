Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbWJKSH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbWJKSH2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbWJKSH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:07:28 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:30670 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161079AbWJKSH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:07:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=gQwbQNxrA1pbj2lOAO80xryWg6oNNB8O46xFnal2Ulsm14Ti+TrCElEx28W2SwbsNrizFTt4Y1551bMR3RSvjbALQRA2U3sqhMEe3nkjgWpGTnANUbTsB3uYFFkohr8tjzyo+9g/es3or+zsMcjjUMe8aplJT7gpgahOXuYNIQg=
Date: Wed, 11 Oct 2006 23:37:13 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
To: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: [PATCH] Add entry.S labels to tag file
Message-ID: <20061011180713.GA12166@satan.home.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The below patch add functions defined using ENTRY macro to the tag
file generated 

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

diff --git a/Makefile b/Makefile
index 274b780..42efa59 100644
--- a/Makefile
+++ b/Makefile
@@ -1316,7 +1316,8 @@ define xtags
 	    $(all-sources) | xargs $1 -a \
 		-I __initdata,__exitdata,__acquires,__releases \
 		-I EXPORT_SYMBOL,EXPORT_SYMBOL_GPL \
-		--extra=+f --c-kinds=+px; \
+		--extra=+f --c-kinds=+px \
+		--regex-asm='/ENTRY\(([^)]*)\).*/\1/'; \
 	    $(all-kconfigs) | xargs $1 -a \
 		--langdef=kconfig \
 		--language-force=kconfig \
