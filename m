Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVCBOKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVCBOKW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 09:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVCBOKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 09:10:21 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64530 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262302AbVCBOIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 09:08:37 -0500
Date: Wed, 2 Mar 2005 15:08:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.11-rc4-mm1 patch] fix buggy IEEE80211_CRYPT_* selects
Message-ID: <20050302140833.GD4608@stusta.de>
References: <20050223014233.6710fd73.akpm@osdl.org> <20050226113123.GJ3311@stusta.de> <42256078.1040002@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42256078.1040002@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 01:43:04AM -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >+	select CRYPTO
> > 	select CRYPTO_AES
> > 	---help---
> > 	Include software based cipher suites in support of IEEE 802.11i 
> > 	(aka TGi, WPA, WPA2, WPA-PSK, etc.) for use with CCMP enabled 
> > 	networks.
> >@@ -54,10 +55,11 @@
> > 	"ieee80211_crypt_ccmp".
> > 
> > config IEEE80211_CRYPT_TKIP
> > 	tristate "IEEE 802.11i TKIP encryption"
> > 	depends on IEEE80211
> >+	select CRYPTO
> > 	select CRYPTO_MICHAEL_MIC
> 
> 
> 'select CRYPTO_AES' should 'select CRYPTO' automatically, I would hope.

This would result in a recursive dependency.

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

