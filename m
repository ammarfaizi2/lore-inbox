Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422641AbWI2VY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422641AbWI2VY7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422823AbWI2VY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:24:59 -0400
Received: from 242.178.36.72.reverse.layeredtech.com ([72.36.178.242]:37555
	"EHLO tapestrysystems.com") by vger.kernel.org with ESMTP
	id S1422641AbWI2VY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:24:58 -0400
Message-ID: <451D8EB4.6020000@madrabbit.org>
Date: Fri, 29 Sep 2006 14:23:00 -0700
From: Ray Lee <ray-lk@madrabbit.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, dbtsai@gmail.com,
       John Linville <linville@tuxdriver.com>, netdev@vger.kernel.org,
       Bcm43xx-dev@lists.berlios.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bcm43xx softMac Driver in 2.6.18
References: <4513E308.10507@lwfinger.net> <2c0942db0609222303o50e47156xe6af9a50ed8301c8@mail.gmail.com> <200609231141.26090.rjw@sisk.pl> <45156612.2080906@madrabbit.org> <4515972F.9080307@lwfinger.net>
In-Reply-To: <4515972F.9080307@lwfinger.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(re-adding linux-kernel.)

Larry Finger wrote:
> Would you please test the attached patch that should be applied to a
> vanilla 2.6.18? I'm currently running it, but only for a few minutes. It
> comes up fine and I ran it through several ifdown/ifup cycles without
> any problem.

Okay, this is far better than vanilla 2.6.18 (or your other patch). I've
been running this for six hours so far with no troubles, when before I'd
have a hard system freeze within a minute or two of associating (or
trying to associate) with an access point.

As for -stable, the patch is sorta, y'know, ginormous:

 bcm43xx.h         |  181 +++++-----
 bcm43xx_debugfs.c |   80 ++++
 bcm43xx_debugfs.h |    1
 bcm43xx_dma.c     |  583 +++++++++++++++++++++++-----------
 bcm43xx_dma.h     |  296 +++++++++++++----
 bcm43xx_leds.c    |   10
 bcm43xx_main.c    |  905
+++++++++++++++++++++++++++++++-----------------------
 bcm43xx_main.h    |    6
 bcm43xx_phy.c     |   48 +-
 bcm43xx_pio.c     |    4
 bcm43xx_sysfs.c   |   46 +-
 bcm43xx_wx.c      |  121 +++----
 12 files changed, 1426 insertions(+), 855 deletions(-)

OTOH, the current version is completely unusable on this system, so I
don't know if the right path is to revert the driver to 2.6.17's
version, or to try to move forward with the patch when it's had hard
review and testing.

I'm heading out on vacation for the next two weeks. I'll catch up with
any mail directed to me for more things to try (or report about this
specific system), if requested, when I get back. (Or catch me today.)

Thank you very much for your help,

Ray
