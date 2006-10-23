Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWJWPxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWJWPxr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWJWPxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:53:47 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.8]:52488 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S964879AbWJWPxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:53:46 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Patrick McHardy <kaber@trash.net>
Subject: Re: 2.6.19-rc2: ieee80211/ipw2200 regression
Date: Mon, 23 Oct 2006 16:53:48 +0100
User-Agent: KMail/1.9.5
Cc: Zhu Yi <yi.zhu@intel.com>, LKML <linux-kernel@vger.kernel.org>,
       jketreno@linux.intel.com
References: <200610230244.43948.s0348365@sms.ed.ac.uk> <200610231635.49869.s0348365@sms.ed.ac.uk> <453CE3A4.7030003@trash.net>
In-Reply-To: <453CE3A4.7030003@trash.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610231653.48797.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 October 2006 16:45, Patrick McHardy wrote:
> Alistair John Strachan wrote:
> > Tried compiling as a module too and the ieee80211 system doesn't load
> > arc4.ko before bailing out. If I reboot, load it myself and try again, it
> > still doesn't work.
>
> Do you have CONFIG_CRYPTO_ECB enabled? I think this patch is needed.

Good catch, I did need this and it wasn't enabled.

Thanks Patrick. From a quick grep of the tree for ecb(, I think 
CONFIG_PPP_MPPE and IEEE80211_CRYPT_TKIP will also need a similar patch.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
