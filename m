Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261555AbSJUTG3>; Mon, 21 Oct 2002 15:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261567AbSJUTG3>; Mon, 21 Oct 2002 15:06:29 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:22801 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261555AbSJUTG2>;
	Mon, 21 Oct 2002 15:06:28 -0400
Date: Mon, 21 Oct 2002 21:11:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jaroslav Kysela <perex@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: sound/core/wrappers.c __GENKSYMS__ usage
Message-ID: <20021021211120.A6964@mars.ravnborg.org>
Mail-Followup-To: Jaroslav Kysela <perex@suse.cz>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaroslav

The usage of __GENKSYMS__ in sound/core/wrappers.c looks wrong.

>From the file:
#include <linux/version.h>
#include <linux/config.h>
#ifdef ALSA_BUILD
#if defined(CONFIG_MODVERSIONS) && !defined(__GENKSYMS__) && !defined(__DEPEND__)
#define MODVERSIONS
#include <linux/modversions.h>
#include "sndversions.h"
#endif
#endif

So __GENKSYMS__ etc is used to protect against inclusion of modversions.h
and sndversion.h.
The latter is not present in my tree (2.5.44).
__DEPEND__ is no longer used.

I do not see the purpose of this - please explain.

	Sam
