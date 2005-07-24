Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVGXVuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVGXVuG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 17:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVGXVuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 17:50:06 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:1667 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261376AbVGXVuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 17:50:04 -0400
From: Grant Coady <lkml@dodo.com.au>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 test: finding compile errors with make randconfig
Date: Mon, 25 Jul 2005 07:49:54 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <qf28e112gdebndkd6vlqh6naeg3mkedlc8@4ax.com>
References: <f8b6e1h2t4tlto7ia8gs8aanpib68mhit6@4ax.com> <20050724091327.GQ3160@stusta.de> <glq7e1ttejp2sh7uuo6nil2vafljdprkpk@4ax.com> <20050724203932.GX3160@stusta.de> <0fv7e11ejvimjkfqib95n93hl34icavnbu@4ax.com> <20050724212721.GA3160@stusta.de>
In-Reply-To: <20050724212721.GA3160@stusta.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2005 23:27:22 +0200, Adrian Bunk <bunk@stusta.de> wrote:
>Looking at the .config, the problem is actually:
>  CONFIG_BROKEN=y
>
>You should edit init/Kconfig to disallow CONFIG_CLEAN_COMPILE=n, since 
>any errors you see with CONFIG_BROKEN=y aren't interesting.

Very good point.

$ grep CONFIG_BROKEN=y *config |wc -l
24

>From 106 .configs, trap for young players...  I'll skip compiling 
"CONFIG_BROKEN=y" .configs then.

Thanks,
Grant.

