Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319082AbSHSUje>; Mon, 19 Aug 2002 16:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319083AbSHSUje>; Mon, 19 Aug 2002 16:39:34 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:44048 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S319082AbSHSUjd>;
	Mon, 19 Aug 2002 16:39:33 -0400
Date: Mon, 19 Aug 2002 22:53:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: DervishD <raul@pleyades.net>
Cc: willy@w.ods.org, linux-kernel@vger.kernel.org
Subject: Re: make allyesconfig?
Message-ID: <20020819225317.A1529@mars.ravnborg.org>
Mail-Followup-To: DervishD <raul@pleyades.net>, willy@w.ods.org,
	linux-kernel@vger.kernel.org
References: <3D6017E8.mail17T111BQN@viadomus.com> <20020819043104.GA25502@alpha.home.local> <3D60F1CB.mail91Q1LZTC8@viadomus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D60F1CB.mail91Q1LZTC8@viadomus.com>; from raul@pleyades.net on Mon, Aug 19, 2002 at 03:25:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 03:25:31PM +0200, DervishD wrote:
>     Thanks for your answer :). I'm particularly interested in
> allmodconfig for compilation problems.
Take a copy of Configure from Linux-2.5

and add the following lines to the top-level Makefile around line 300:

+randconfig: symlinks
+       $(CONFIG_SHELL) scripts/Configure -r arch/$(ARCH)/config.in
+
+allyesconfig: symlinks
+       $(CONFIG_SHELL) scripts/Configure -y arch/$(ARCH)/config.in
+
+allnoconfig: symlinks
+       $(CONFIG_SHELL) scripts/Configure -n arch/$(ARCH)/config.in
+
+allmodconfig: symlinks
+       $(CONFIG_SHELL) scripts/Configure -m arch/$(ARCH)/config.in
+
+defconfig: symlinks
+       yes '' | $(CONFIG_SHELL) scripts/Configure -d arch/$(ARCH)/config.in

That gives you the targets you have requested from 2.5

	Sam
