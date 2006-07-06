Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbWGFMV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWGFMV6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 08:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWGFMV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 08:21:58 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:17025 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1030227AbWGFMV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 08:21:57 -0400
Message-ID: <44AD018D.8050204@gentoo.org>
Date: Thu, 06 Jul 2006 13:26:53 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: linux@horizon.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
References: <20060706044838.30651.qmail@science.horizon.com>
In-Reply-To: <20060706044838.30651.qmail@science.horizon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:
> I utterly fail to see why multiple, generally knowledgeable people are
> claiming that encryption in a fingerprint scanner is desirable.
> 
> As far as I can tell, the only thing you want is AUTHENTICATION - you
> want proof that you are getting a "live" scan taken from a user
> who's present, and not a replay of what was sent last week.
> 
> This is called "freshness" and is usually provided by including a
> random "nonce" (known in other contexts as "magic cookie") in the
> authenticated data.

The Digital Persona readers apparently use a challenge-response 
authentication scheme for the encryption. I think I know the 
challenge-sending and response-reading command structure but have not 
yet examined their effect on the encrypted fingerprint data.

> Not that I expect "A-1 Computer Corporation" in Shenzhen to have a clue
> about these things, but you'd think that Microsoft would have one or
> two competent employees left on the payroll.

Now theres an interesting story in this area. The Microsoft fingerprint 
readers are based on Digital Persona devices, and actually they seem to 
be completely identical. But when comparing bus traffic for the DP 
devices vs the MS devices, the DP devices send encrypted fingerprint 
data and the MS devices send it as unencrypted 8-bit greyscale.

Anyway, further investigation shows a 1 bit difference in the firmware 
uploaded to each device, and I have confirmed that this bit turns 
encryption on and off.

IOW, MS's device are capable of encryption but they explicitly turned it 
off at the firmware level.

Daniel
