Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F2EC43215
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 03:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A642240E
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 03:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfKTDOd (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 22:14:33 -0500
Received: from smtpbg704.qq.com ([203.205.195.105]:53240 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727336AbfKTDOd (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 19 Nov 2019 22:14:33 -0500
X-QQ-mid: bizesmtp12t1574219668tqqf9bh5
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 20 Nov 2019 11:14:28 +0800 (CST)
X-QQ-SSF: 01400000002000T0ZVF0000A0000000
X-QQ-FEAT: dMLGSgzcGovQ0zrdTU0J3i+mzsgkP5V3SQigowX1EdxjncGPYn0bJaS3+k8ju
        DL5twP6BziCcLp/NAIByVQB/G8x2Nj/CWMBFANb9TICcy2YdxE1rlj2drZbqVbEaiDz90Jz
        JeLHlmnORw94ti/s1orK5KOtWCpGnNxa32aCUqBjC4snqxZFbmZrCGoD9iSsZQUpnyu9L+V
        oCCko9lup9Ngljx4lXaYr0DYM5fHGMXo6ajVG9gaqtocl6pgtDuk30DoXUhd8FRMf2/bclF
        dTZmC6zyvg8ykahu9Wnvw5yPHu553kFC3gyWZgMaDEPtXcHECG6F2vLxw4MGSdTdeZQTKAy
        n0feYh11wmJhg3N6mC33wQSmsLYhQ==
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org
Subject: [PATCH liburing 3/3] built liburing.so and test binary first when runtests
Date:   Wed, 20 Nov 2019 11:14:22 +0800
Message-Id: <20191120031422.49382-3-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120031422.49382-1-liuyun01@kylinos.cn>
References: <20191120031422.49382-1-liuyun01@kylinos.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 Makefile      | 2 +-
 test/Makefile | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 8af1c3a..9e13218 100644
--- a/Makefile
+++ b/Makefile
@@ -13,7 +13,7 @@ all:
 	@$(MAKE) -C test
 	@$(MAKE) -C examples
 
-runtests:
+runtests: all
 	@$(MAKE) -C test runtests
 runtests-loop:
 	@$(MAKE) -C test runtests-loop
diff --git a/test/Makefile b/test/Makefile
index 97e88ea..60ae08f 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -41,7 +41,7 @@ accept-link: XCFLAGS = -lpthread
 clean:
 	rm -f $(all_targets) $(test_objs)
 
-runtests:
+runtests: all
 	@./runtests.sh $(all_targets)
-runtests-loop:
+runtests-loop: all
 	@./runtests-loop.sh $(all_targets)
-- 
2.17.1



