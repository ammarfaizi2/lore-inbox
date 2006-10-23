Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWJWQDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWJWQDQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbWJWQDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:03:16 -0400
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:8198 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751502AbWJWQDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:03:15 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Patrick McHardy <kaber@trash.net>
Subject: Re: 2.6.19-rc2: ieee80211/ipw2200 regression
Date: Mon, 23 Oct 2006 17:03:17 +0100
User-Agent: KMail/1.9.5
Cc: Zhu Yi <yi.zhu@intel.com>, LKML <linux-kernel@vger.kernel.org>,
       jketreno@linux.intel.com
References: <200610230244.43948.s0348365@sms.ed.ac.uk> <453CE3A4.7030003@trash.net> <200610231653.48797.s0348365@sms.ed.ac.uk>
In-Reply-To: <200610231653.48797.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610231703.17557.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 October 2006 16:53, Alistair John Strachan wrote:
> On Monday 23 October 2006 16:45, Patrick McHardy wrote:
> > Alistair John Strachan wrote:
> > > Tried compiling as a module too and the ieee80211 system doesn't load
> > > arc4.ko before bailing out. If I reboot, load it myself and try again,
> > > it still doesn't work.
> >
> > Do you have CONFIG_CRYPTO_ECB enabled? I think this patch is needed.
>
> Good catch, I did need this and it wasn't enabled.
>
> Thanks Patrick. From a quick grep of the tree for ecb(, I think
> CONFIG_PPP_MPPE and IEEE80211_CRYPT_TKIP will also need a similar patch.

Patrick, these also need CRYPTO_MANAGER, or it still doesn't work. With 
CRYPTO_MANAGER, CRYPTO_ECB and CRYPTO_ARC4, ieee80211 WEP starts working 
again.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
