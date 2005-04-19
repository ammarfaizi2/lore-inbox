Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVDSVma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVDSVma (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 17:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVDSVma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 17:42:30 -0400
Received: from mail.dif.dk ([193.138.115.101]:60550 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261266AbVDSVmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 17:42:16 -0400
Date: Tue, 19 Apr 2005 23:45:16 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] sound: trivial warning fix for emu10k1
Message-ID: <Pine.LNX.4.62.0504192338090.2074@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When building with gcc -W sound/pci/emu10k1/emupcm.c produces this little 
warning in 2.6.12-rc2-mm3 : 
  sound/pci/emu10k1/emupcm.c:265: warning: `inline' is not at beginning of declaration
No big deal, but trivial to fix.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 sound/pci/emu10k1/emupcm.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.12-rc2-mm3-orig/sound/pci/emu10k1/emupcm.c	2005-04-11 21:20:58.000000000 +0200
+++ linux-2.6.12-rc2-mm3/sound/pci/emu10k1/emupcm.c	2005-04-19 23:37:10.000000000 +0200
@@ -262,7 +262,7 @@ static unsigned int emu10k1_select_inter
  *
  * returns: cache invalidate size in samples
  */
-static int inline emu10k1_ccis(int stereo, int w_16)
+static inline int emu10k1_ccis(int stereo, int w_16)
 {
 	if (w_16) {
 		return stereo ? 24 : 26;




--- 
PS. Please CC me on replies.


