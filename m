Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWIGLG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWIGLG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 07:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbWIGLG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 07:06:57 -0400
Received: from natreg.rzone.de ([81.169.145.183]:46056 "EHLO natreg.rzone.de")
	by vger.kernel.org with ESMTP id S1751656AbWIGLGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 07:06:55 -0400
Date: Thu, 7 Sep 2006 13:05:13 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Kirill Korotaev <dev@openvz.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Mirkin <amirkin@sw.ru>, devel@openvz.org, mikpe@it.uu.se,
       sam@ravnborg.org, bunk@stusta.de
Subject: Re: [PATCH] fail kernel compilation in case of unresolved symbols (v2)
Message-ID: <20060907110513.GA22319@aepfle.de>
References: <44FFEE5D.2050905@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44FFEE5D.2050905@openvz.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, Kirill Korotaev wrote:

> At stage 2 modpost utility is used to check modules.
> In case of unresolved symbols modpost only prints warning.
> 
> IMHO it is a good idea to fail compilation process in case of
> unresolved symbols (at least in modules coming with kernel),
> since usually such errors are left unnoticed, but kernel
> modules are broken.

It clearly depends on the context. An unimportant dvb module may have
unresolved symbols, but the drivers for your root filesystem should
rather not have unresolved symbols.

Better leave the current default, your patch seems to turn an unresolved
symbol with "unknown importance" into a hard error.
