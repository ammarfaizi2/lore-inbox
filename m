Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161259AbVKIVw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161259AbVKIVw7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161260AbVKIVw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:52:59 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:45323 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1161259AbVKIVwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:52:55 -0500
Date: Wed, 9 Nov 2005 16:52:39 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Pantelis Antoniou <panto@intracom.gr>, linuxppc-embedded@ozlabs.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.14 (take #2)] fec_8xx: make CONFIG_FEC_8XX depend on CONFIG_8xx
Message-ID: <20051109215237.GC24099@tuxdriver.com>
Mail-Followup-To: Pantelis Antoniou <panto@intracom.gr>,
	linuxppc-embedded@ozlabs.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20051106025701.GA9698@tuxdriver.com> <436F07F5.1030206@intracom.gr> <20051107182031.GC13797@tuxdriver.com> <20051107182459.GD13797@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107182459.GD13797@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 01:24:59PM -0500, John W. Linville wrote:
> Change CONFIG_FEC_8XX to depend on CONFIG_8xx instead of CONFIG_FEC.
> CONFIG_FEC depends on ColdFire CPUs, which does not apply for the
> PPC 8xx processors.

FWIW, I have this patch available on the linville-fec_8xx branch of
netdev-jwl as described below.

Thanks,

John

---

The following changes since commit 330d57fb98a916fa8e1363846540dd420e99499a:
  Al Viro:
        Fix sysctl unregistration oops (CVE-2005-2709)

are found in the git repository at:

  git://git.tuxdriver.com/git/netdev-jwl.git linville-fec_8xx

John W. Linville:
      fec_8xx: make CONFIG_FEC_8XX depend on CONFIG_8xx

 drivers/net/fec_8xx/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/fec_8xx/Kconfig b/drivers/net/fec_8xx/Kconfig
index 94e7a9a..a84c232 100644
--- a/drivers/net/fec_8xx/Kconfig
+++ b/drivers/net/fec_8xx/Kconfig
@@ -1,6 +1,6 @@
 config FEC_8XX
 	tristate "Motorola 8xx FEC driver"
-	depends on NET_ETHERNET && FEC
+	depends on NET_ETHERNET && 8xx
 	select MII
 
 config FEC_8XX_GENERIC_PHY
-- 
John W. Linville
linville@tuxdriver.com
