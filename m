Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVBGTlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVBGTlA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVBGThi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:37:38 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:11190 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261275AbVBGTdt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:33:49 -0500
Message-ID: <4207C29B.8030105@free.fr>
Date: Mon, 07 Feb 2005 20:33:47 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Adam Belay <ambx1@neo.rr.com>
Subject: [bug] pnp_register_card_driver/pnp_unregister_card_driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

pnp_register_driver could fail and return <0 result, in this case the 
driver shouldn't be pnp_unregister_driver.

But if you look in pnp_register_card_driver, the result isn't checked. 
And it is always pnp_unregister_driver in pnp_unregister_card_driver.

I know that pnp_register_card_driver shouldn't fail in normal condition, 
but who know...


Matthieu
