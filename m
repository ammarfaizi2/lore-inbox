Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263992AbTE0RhR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263986AbTE0RhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:37:17 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:5504 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S263992AbTE0RhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:37:14 -0400
Date: Tue, 27 May 2003 19:50:21 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] matroxfb update to new API
Message-ID: <20030527175021.GA2453@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I just created stripped down version of matroxfb - it is available
as diff for 2.5.70 at 
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/mga-stripdown-2.5.70.gz.

  I'll still update my own version of fbdev layer and matroxfb, as
this stripped down driver is quite unusable for me.
						Petr Vandrovec

----- Forwarded message from Petr Vandrovec <vandrove@vc.cvut.cz> -----

Date: Tue, 27 May 2003 19:46:31 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Subject: [PATCH] matroxfb update to new API

Hi Linus,
  as it appears that current fbdev layer is not going to disappear,
there is update of matroxfb. I'm sorry that it is quite large, but
due to completely changed underlying API there is no reasonable way 
how to split it into smaller pieces.

(Mis) Features:
Removed support for text mode. No way for it with current API.
Removed support for hardware cursor. Generic cursor code has enough 
	troubles as is, in software mode.
No reasonable fbset support... It is especially annoying on multihead
	system, as 'stty cols XXX rows YYY' does not change pixclock...
Removed fastfont support. No way for it with current API.

(Mis) Features inherited from generic fbdev API:
Cursor on other framebuffers than primary one does not blink.
Contents of visible, but not foreground, display is not updated.

						Thanks,
							Petr Vandrovec
