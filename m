Return-Path: <linux-kernel-owner+w=401wt.eu-S1751285AbWLOINa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWLOINa (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 03:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWLOINa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 03:13:30 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43220 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbWLOIN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 03:13:29 -0500
Date: Fri, 15 Dec 2006 00:13:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: [ALSA PATCH] alsa-git merge request
Message-Id: <20061215001319.b6dd7198.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0612150849410.13335@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0612150849410.13335@tm8103.perex-int.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006 08:52:48 +0100 (CET)
Jaroslav Kysela <perex@suse.cz> wrote:

> Linus, please do an update from:
> 
>   http://www.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
>   (linus branch)
> 
> The GNU patch is available at:
> 
>   ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2006-12-15.patch.gz
> 

It's going to need this fix

From: Andrew Morton <akpm@osdl.org>

Cc: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/input/touchscreen/ucb1400_ts.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/input/touchscreen/ucb1400_ts.c~git-alsa-more-borkage drivers/input/touchscreen/ucb1400_ts.c
--- a/drivers/input/touchscreen/ucb1400_ts.c~git-alsa-more-borkage
+++ a/drivers/input/touchscreen/ucb1400_ts.c
@@ -83,7 +83,7 @@
 
 
 struct ucb1400 {
-	ac97_t			*ac97;
+	struct snd_ac97		*ac97;
 	struct input_dev	*ts_idev;
 
 	int			irq;
_

