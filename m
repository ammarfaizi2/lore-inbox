Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993112AbWJUPuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993112AbWJUPuK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 11:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993111AbWJUPuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 11:50:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:63477 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S2993112AbWJUPuI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 11:50:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 1/7] KVM: userspace interface
Date: Sat, 21 Oct 2006 17:50:02 +0200
User-Agent: KMail/1.9.4
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <4537818D.4060204@qumranet.com> <Pine.LNX.4.61.0610192212590.8142@yvahk01.tjqt.qr> <453877DB.4050704@qumranet.com>
In-Reply-To: <453877DB.4050704@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610211750.02559.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 October 2006 09:16, Avi Kivity wrote:
> Jan Engelhardt wrote:
> >> +#ifndef __user
> >> +#define __user
> >> +#endif
> >>    
> >
> > SHRUG. You should include <linux/compiler.h> instead of doing that. (And
> > on top, it may happen that compiler.h is automatically slurped in like
> > config.h, someone else could answer that)
> >  
>
> This is for userspace.  If there's a better solution I'll happily
> incorporate it.

It should just work without this, when you do 'make headers_install'.
See the top of scripts/Makefile.headersinst.

	Arnd <><
