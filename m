Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264154AbUHOK1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUHOK1V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 06:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266572AbUHOK1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 06:27:21 -0400
Received: from everest.2mbit.com ([24.123.221.2]:5014 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S264154AbUHOK1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 06:27:19 -0400
Message-ID: <411F3A48.2030201@greatcn.org>
Date: Sun, 15 Aug 2004 18:26:16 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: kai@tp1.ruhr-uni-bochum.de, sam@ravnborg.org, linux-kernel@vger.kernel.org
X-Scan-Signature: 0c1945f502a06f7766c9348c347b6b03
X-SA-Exim-Connect-IP: 218.24.189.67
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: [PATCH] Remove obsolete HEAD in top Makefile
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  3.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.189.67 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.0+cvs20040712 (built Mon, 09 Aug 2004 23:30:37 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This removes an obsolete variable in the top Makefile. It is used in 2.4 
Makefile.
Now the 2.6 kbuild is no longer using it. I have tested it.

    coywolf


Signed-off-by: Coywolf Qi Hunt <coywolf@greatcn.org>

--- linux-2.6.8/Makefile~remove-HEAD    2004-08-15 05:46:21.215837742 -0400
+++ linux-2.6.8/Makefile        2004-08-15 05:46:41.296231310 -0400
@@ -506,7 +506,6 @@ libs-y              := $(libs-y1) $(libs-y2)
 #       normal descending-into-subdirs phase, since at that time
 #       we cannot yet know if we will need to relink vmlinux.
 #      So we descend into init/ inside the rule for vmlinux again.
-head-y += $(HEAD)
 vmlinux-objs := $(head-y) $(init-y) $(core-y) $(libs-y) $(drivers-y) 
$(net-y)

 quiet_cmd_vmlinux__ = LD      $@

-- 
Coywolf Qi Hunt
Homepage http://greatcn.org/~coywolf/
Admin of http://GreatCN.org and http://LoveCN.org

