Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbWJ3FIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbWJ3FIp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 00:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbWJ3FIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 00:08:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:62526 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161015AbWJ3FIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 00:08:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=Myy0Xkdk62cspQJwiRqm1Djl81Bz45g2/0zm+OTVSCypuJ6/nWR32zwbwGayKyxj7OKGoWkX8hKrfr4MqdeXyd9fLz3cEg/lrTkPE/1v+mvMddfYjoFyRM0ZIZruZczovUSF3ryhX+IXJ9Zsierw7jeS8iTTAd9dEcg+gj38A7I=
Message-ID: <76366b180610292108o62b0b480v91356fb957fbebcc@mail.gmail.com>
Date: Mon, 30 Oct 2006 00:08:43 -0500
From: "Andrew Paprocki" <andrew@ishiboo.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fixed uninitialized variable warning in drivers/md/dm-exception-store.c.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: a809169df23c5409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed uninitialized variable warning in drivers/md/dm-exception-store.c.

Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>

---
 drivers/md/dm-exception-store.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/md/dm-exception-store.c b/drivers/md/dm-exception-store.c
index 99cdffa..d50ffde 100644
--- a/drivers/md/dm-exception-store.c
+++ b/drivers/md/dm-exception-store.c
@@ -413,7 +413,7 @@ static void persistent_destroy(struct ex

 static int persistent_read_metadata(struct exception_store *store)
 {
-       int r, new_snapshot;
+       int r, new_snapshot = 0;
        struct pstore *ps = get_info(store);

        /*
--
1.4.1.1
