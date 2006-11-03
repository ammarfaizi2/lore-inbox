Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753270AbWKCPkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbWKCPkI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 10:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753272AbWKCPkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 10:40:08 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:28178 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1753270AbWKCPkH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 10:40:07 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andreas Schwab <schwab@suse.de>
Subject: Re: orinoco driver question
Date: Fri, 3 Nov 2006 16:38:51 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200611031613.25483.m.kozlowski@tuxland.pl> <jeejsk8s22.fsf@sykes.suse.de>
In-Reply-To: <jeejsk8s22.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611031638.51425.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I don't think this patch decreases code readability.
>
> It breaks the interface.

You mean this part:

-       *val = priv->prefer_port3;
+       *extra = (char)priv->prefer_port3;

It can be done another way. 

-       *val = priv->prefer_port3;
+	*(int *)extra = priv->prefer_port3;

Where can I read about this 'interface'?

Regards,

	Mariusz
