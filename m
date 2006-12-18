Return-Path: <linux-kernel-owner+w=401wt.eu-S1753961AbWLRNFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961AbWLRNFL (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 08:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753963AbWLRNFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 08:05:11 -0500
Received: from main.gmane.org ([80.91.229.2]:37922 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753961AbWLRNFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 08:05:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Jellinghaus <aj@ciphirelabs.com>
Subject: Re: [ANN] Acrypto asynchronous crypto layer 2.6.19 release.
Date: Mon, 18 Dec 2006 14:00:26 +0100
Message-ID: <458690EA.2000405@ciphirelabs.com>
References: <20061216191521.GA26549@2ka.mipt.ru> <4586458E.6000503@dungeon.inka.de> <20061218095740.GA5219@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: linux-crypto@vger.kernel.org, netdev@vger.kernel.org
X-Gmane-NNTP-Posting-Host: ciphirelabs.net
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
In-Reply-To: <20061218095740.GA5219@2ka.mipt.ru>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> Actually I do not recall what is 'size retrictions' - if you talk about
> possibility to use software crypto provider, which supports one cipher
> in a time, then yes, but it is intended to be used with hardware though.
> Otherwise I do not recall any problems pointed to me.

sorry, "size restriction" was the wrong term. acrypto only supports
"sync provider only supports AES-128 in CBC mode, so if you try
different ciphers, there can be some problems."

and I'm using dm-crypto with aes-cbc-essiv:sha256 and your acrypto patch
breaks this setup - not only acrypto doesn't provide crypto capability 
for my setup, but with this patch it is not offered by the old mechanism
either, so my system has no way to decrypt the root partition. note:
that was with the 2.6.18 patch, no idea if it is different now.

so while the patch adds new features, it also removes some features -
not sure if always (via patch) or via compile option or via module
load. also I'm not sure if acrypto can be disabled via kernel command
line to get the old behaviour (including aes-cbc-essiv:sha256 support
for dm-crypt).

would be nice to track those issues, so people testing your patch
are aware of the situation.

Regards, Andreas

