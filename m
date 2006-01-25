Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWAYA0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWAYA0u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 19:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWAYA0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 19:26:49 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:62478 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750899AbWAYA0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 19:26:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Tn4gT2yJNPDuw4BDUcWp84LT0ZOD6bu8eYaIDk4LA7JDxXEDowt3gzbklrA/jd6hmmKabArKYgZ2FRQSPYmvYACt4oGR9Xln72HSsb2Tsz7eAbHtBxYrKcxJOFT/U8g7tRLi1OD3yg6tIJvqgRfN+6MZZMlUJdcd6smVXh7ds3o=
Date: Wed, 25 Jan 2006 03:44:29 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] ipw2200: fix ->eeprom[EEPROM_VERSION] check
Message-ID: <20060125004429.GE3234@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

priv->eeprom is a pointer.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/net/wireless/ipw2200.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/ipw2200.c
+++ b/drivers/net/wireless/ipw2200.c
@@ -2456,7 +2456,7 @@ static void ipw_eeprom_init_sram(struct 
 	   copy.  Otherwise let the firmware know to perform the operation
 	   on it's own
 	 */
-	if ((priv->eeprom + EEPROM_VERSION) != 0) {
+	if (priv->eeprom[EEPROM_VERSION] != 0) {
 		IPW_DEBUG_INFO("Writing EEPROM data into SRAM\n");
 
 		/* write the eeprom data to sram */

