Return-Path: <linux-kernel-owner+w=401wt.eu-S1754008AbWLRNjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbWLRNjt (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 08:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754009AbWLRNjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 08:39:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:60547 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008AbWLRNjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 08:39:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=G4Imf7fIfT8Oz0wLIkgc2AcE8QJitHZXa/jhyJOuKsvM7qEa3rGiYZaI0fqSnUHfmX7Jv8CXuyRqjynJkkJaE6RNBHjqoz5VowMRf1Tu/kTaxuzw4rsybl1Dmv9NouiehFzy9g6gWB8+hrtbVbIkptVw2yIJe/yPVvDParZRMRo=
Date: Mon, 18 Dec 2006 13:38:09 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, liam.girdwood@wolfsonmicro.com
Subject: [-mm patch] kill pxa2xx Kconfig warning
Message-ID: <20061218133809.GD24405@slug>
References: <20061214225913.3338f677.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214225913.3338f677.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 10:59:13PM -0800, Andrew Morton wrote:
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc1/2.6.20-rc1-mm1/
>  git-alsa.patch
Hi,

The following patch silences the following Kconfig warning:
scripts/kconfig/conf -s arch/i386/Kconfig
sound/soc/pxa/Kconfig:18:warning: 'select' used by config symbol 'SND_PXA2XX_SOC_AC97' refer to undefined symbol 'SND_AC97_BUS'

Regards,
Frederik

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>


diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index a07598c..579e1c8 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -15,7 +15,7 @@ config SND_PXA2XX_AC97
 
 config SND_PXA2XX_SOC_AC97
 	tristate
-	select SND_AC97_BUS
+	select AC97_BUS
 	select SND_SOC_AC97_BUS
 
 config SND_PXA2XX_SOC_I2S
