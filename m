Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWDEAEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWDEAEI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWDEABu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:01:50 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:22722
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750967AbWDEABR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:01:17 -0400
Date: Tue, 4 Apr 2006 17:00:33 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       git-commits-head@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 12/26] Mark longhaul driver as broken.
Message-ID: <20060405000033.GM27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="mark-longhaul-driver-as-broken.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>

[CPUFREQ] Mark longhaul driver as broken.
This seems to work for a short period of time, but when
used in conjunction with a userspace governor that changes
the frequency regularly, it's only a matter of time before
everything just locks up.

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/i386/kernel/cpu/cpufreq/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.16.1.orig/arch/i386/kernel/cpu/cpufreq/Kconfig
+++ linux-2.6.16.1/arch/i386/kernel/cpu/cpufreq/Kconfig
@@ -203,6 +203,7 @@ config X86_LONGRUN
 config X86_LONGHAUL
 	tristate "VIA Cyrix III Longhaul"
 	select CPU_FREQ_TABLE
+	depends on BROKEN
 	help
 	  This adds the CPUFreq driver for VIA Samuel/CyrixIII, 
 	  VIA Cyrix Samuel/C3, VIA Cyrix Ezra and VIA Cyrix Ezra-T 

--
