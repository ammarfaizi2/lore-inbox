Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWG3Xgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWG3Xgy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 19:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWG3Xgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 19:36:53 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:53468 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932478AbWG3Xgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 19:36:53 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 00/12] making the kernel -Wshadow clean - The initial step
Date: Mon, 31 Jul 2006 01:36:58 +0200
User-Agent: KMail/1.9.1
Cc: Krzysztof Halasa <khc@pm.waw.pl>, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, nikita@clusterfs.com, joe@perches.com,
       tali@admingilde.org, jbglaw@lug-owl.de, hch@infradead.org,
       dwmw2@infradead.org, arjan@infradead.org, dmitry.torokhov@gmail.com,
       Valdis.Kletnieks@vt.edu, sam@ravnborg.org, rmk@arm.linux.org.uk,
       rusty@rustcorp.com.au, rdunlap@xenotime.net
References: <200607301830.01659.jesper.juhl@gmail.com> <m3wt9vj94n.fsf@defiant.localdomain> <20060730112917.88d9ae4e.akpm@osdl.org>
In-Reply-To: <20060730112917.88d9ae4e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607310137.00404.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sunday 30 July 2006 20:29 schrieb Andrew Morton:
> While I don't recall any kernel bugs which -Wshadow would have saved us
> from, I think it's a sensible thing to do - it _might_ save us from a bug,
> and we need all the help we can get.

One case where it would have helped in the past is jiffies -- when
experimenting with tickless systems, turning the global jiffies
variable into a macro comes in handy, but that breaks all functions
that have a local variable with the same name.

	Arnd <><
