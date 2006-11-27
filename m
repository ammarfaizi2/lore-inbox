Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756305AbWK0DAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756305AbWK0DAj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 22:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756319AbWK0DAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 22:00:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:15282 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1756305AbWK0DAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 22:00:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=nUmsfzIsxuzfsHSsOGloYGpAJtST8RgGG08OjOG9NzHAyzsHwmDyphSDgplvMqmtDx3fpAox6m3Rgx8eESn+LzQlC/2MBMV1HRQ6Hkp30ThZ0biENjKmL7pYpCZXaMc8puKOTxtDMu3evVBA7nbawf0jErhJTWEOdk6Wmm01TQw=
Message-ID: <456A54CE.4090306@gmail.com>
Date: Mon, 27 Nov 2006 12:00:30 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: vherva@vianova.fi
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7: ide_cd problems
References: <20061125194534.GE9995@vianova.fi>
In-Reply-To: <20061125194534.GE9995@vianova.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva wrote:
> When ripping a cd with grip, I noticed the drive was not in DMA mode. I did
> hdparm -d1 /dev/hdi. The grip process (it uses libcdda_paranoia.so and
> libcdda_interface.so) hung, and attempt to kill it with -KILL failed.
> Eventually it died but remained as zombie:

Known problem but probably won't get fixed.  Just use hdparm only when 
the drive is idle.  Put it somewhere in the boot script.

Hmm... IDE should enable DMA automatically for most cases.  Can you post 
full dmesg?

-- 
tejun
