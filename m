Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbUK3Fcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUK3Fcf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 00:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUK3Fce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 00:32:34 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:26733 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261992AbUK3FcZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 00:32:25 -0500
Date: Tue, 30 Nov 2004 06:32:28 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] move OSS ac97_codec.h to sound/oss/
Message-ID: <20041130053228.GB8211@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20041130013139.GC19821@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041130013139.GC19821@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 02:31:39AM +0100, Adrian Bunk wrote:
 --- linux-2.6.10-rc2-mm3-full/sound/oss/emu10k1/hwaccess.h.old	2004-11-30 02:11:21.000000000 +0100
> +++ linux-2.6.10-rc2-mm3-full/sound/oss/emu10k1/hwaccess.h	2004-11-30 02:12:16.000000000 +0100
> @@ -35,7 +35,7 @@
>  #include <linux/fs.h>
>  #include <linux/sound.h>
>  #include <linux/soundcard.h>
> -#include <linux/ac97_codec.h>
> +#include "../ac97_codec.h"

Such relative includes should be avoided. Set CFLAGS_xxx.o in Makefile instead.
And move include down under #include <asm/xxx>

	Sam
