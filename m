Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWAWPKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWAWPKe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 10:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWAWPKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 10:10:34 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:59383 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751466AbWAWPKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 10:10:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=hezXmjuDA61s7EYLL0wgzy0FDfQSMXRhLsjKz4kiotQKlCmJBPV/n1vWcfRUxm0BKppovr4yoFMK5WpbYiyzj6ImZzo0twV/fGth05AxNfOn37pP4H47ebUqq2gMzy72lI7keW8CKwtaDB/QwirNDwY6T45BHtWopsfnlhxFzo0=
Date: Mon, 23 Jan 2006 18:28:08 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Marek Va?ut <marek.vasut@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] iforce: fix -ENOMEM check
Message-ID: <20060123152808.GA7766@mipter.zuzino.mipt.ru>
References: <200601221250.26792.marek.vasut@gmail.com> <20060122195550.GA19983@mipter.zuzino.mipt.ru> <200601230048.43360.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601230048.43360.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/input/joystick/iforce/iforce-main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -345,7 +345,7 @@ int iforce_init_device(struct iforce *if
 	int i;
 
 	input_dev = input_allocate_device();
-	if (input_dev)
+	if (!input_dev)
 		return -ENOMEM;
 
 	init_waitqueue_head(&iforce->wait);

