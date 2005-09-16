Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbVIPUzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbVIPUzK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 16:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbVIPUzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 16:55:10 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:43303 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750851AbVIPUzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 16:55:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=fvfCPj3GyfnL9R0uFBlhJ6amqjhu+f3qN62h4t7JJfs6mPo4WZhh1rXS32mx///YwyiJ8XYzb4wqnT5ev4ADU8qECbZ7qN1Sq48T5GYoEmYatpXoEy4F/zlPjm8IqHt0/q1mXD7WvQsEv5zwhNePMP9CNB55wkxVvTUwZbNVqpk=
Message-ID: <432B306C.2010304@gmail.com>
Date: Fri, 16 Sep 2005 16:51:56 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org, jgarzik@pobox.com
Subject: [PATCH] eepro.c: module_param_array cleanup
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

num_params is unused (and unusable in this form).

Signed-off-by: Florin Malita <fmalita@gmail.com>
----
diff --git a/drivers/net/eepro.c b/drivers/net/eepro.c
--- a/drivers/net/eepro.c
+++ b/drivers/net/eepro.c
@@ -1797,10 +1797,9 @@ MODULE_AUTHOR("Pascal Dupuis and others"
  MODULE_DESCRIPTION("Intel i82595 ISA EtherExpressPro10/10+ driver");
  MODULE_LICENSE("GPL");

-static int num_params;
-module_param_array(io, int, &num_params, 0);
-module_param_array(irq, int, &num_params, 0);
-module_param_array(mem, int, &num_params, 0);
+module_param_array(io, int, NULL, 0);
+module_param_array(irq, int, NULL, 0);
+module_param_array(mem, int, NULL, 0);
  module_param(autodetect, int, 0);
  MODULE_PARM_DESC(io, "EtherExpress Pro/10 I/O base addres(es)");
  MODULE_PARM_DESC(irq, "EtherExpress Pro/10 IRQ number(s)");
