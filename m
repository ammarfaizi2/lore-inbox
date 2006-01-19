Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161174AbWASL3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161174AbWASL3J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 06:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbWASL3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 06:29:09 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:28339 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161174AbWASL3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 06:29:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=ZGUiVb1Ljc7uwDFKtRMvzRpR99v9q0P4LM8J112OuQJI7EiHlG8AX4Lp/boZNnJQl1Fhl5UclDUpVnY0S4r5lw/JHJoyXINRWN892UvCf0oAmXI1c5I+vhcPMMl8iICF+okZmn7dRoPbp8+4W6jP051LCqxmE49pWmhfIGPRTnM=
Message-ID: <cc723f590601190329h5239c4dfnff23c07a5bbc384e@mail.gmail.com>
Date: Thu, 19 Jan 2006 16:59:05 +0530
From: Aneesh Kumar <aneesh.kumar@gmail.com>
To: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Add entry.S labels to tag file.
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1767_30643192.1137670145830"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1767_30643192.1137670145830
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The below patch add functions defined using ENTRY macro to the tag
file generated
using ctags.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

------=_Part_1767_30643192.1137670145830
Content-Type: text/plain; name=Makefile.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Makefile.diff"

diff --git a/Makefile b/Makefile
index 252a659..8f0cc11 100644
--- a/Makefile
+++ b/Makefile
@@ -1272,7 +1272,7 @@ define cmd_tags
 	CTAGSF=`ctags --version | grep -i exuberant >/dev/null &&     \
                 echo "-I __initdata,__exitdata,__acquires,__releases  \
                       -I EXPORT_SYMBOL,EXPORT_SYMBOL_GPL              \
-                      --extra=+f --c-kinds=+px"`;                     \
+                      --extra=+f --c-kinds=+px --regex-asm=/ENTRY\(([^)]*)\).*/\1/"`;  \
                 $(all-sources) | xargs ctags $$CTAGSF -a
 endef
 

------=_Part_1767_30643192.1137670145830--
