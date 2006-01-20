Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWATTut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWATTut (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWATTut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:50:49 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:13575 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932126AbWATTus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:50:48 -0500
Date: Fri, 20 Jan 2006 20:50:35 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Announce loop-AES-v3.1c file/swap crypto package
Message-ID: <20060120195035.GA9685@mars.ravnborg.org>
References: <43CE6384.284B823C@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CE6384.284B823C@users.sourceforge.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 05:49:24PM +0200, Jari Ruusu wrote:
> - Makefile changed to work around 2.6.16-rc1 build breakage.

Hi Jari.

Care to explain why it is needed to have this in your Makefile:

SR1:=$(shell if grep -q -s                             \
	"^basename_flags.*KBUILD_BASENAME.*KBUILD_STR" \
	$(LS)/scripts/Makefile.lib; then echo y; fi)
...

ifeq ($(SR1),y)
	EF += -D"KBUILD_STR(s)=\#s"
else
        EF += -D"KBUILD_STR(s)=s"
endif


Either something is missing in the support for external modules in the
kernel or you are overdoing some stuff.
If there is something missing in the kernel to support external
modules then please say so, so it can be fixed.

	Sam
