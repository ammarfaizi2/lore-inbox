Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbTLYCdM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 21:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbTLYCdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 21:33:12 -0500
Received: from mail.designassembly.de ([217.115.138.177]:20678 "EHLO
	mail.designassembly.de") by vger.kernel.org with ESMTP
	id S264264AbTLYCdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 21:33:11 -0500
Message-ID: <3FEA4C65.2090903@designassembly.de>
Date: Thu, 25 Dec 2003 03:33:09 +0100
From: Michael Heyse <m.heyse@designassembly.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Giacomo Di Ciocco <admin@nectarine.info>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 "Losing too many ticks!"
References: <3FE9DFA2.5070203@nectarine.info> <20031224185248.GG27687@holomorphy.com>
In-Reply-To: <20031224185248.GG27687@holomorphy.com>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> This is not particularly harmful. It just means the kernel has detected
> some variation in the processor's clock speed and is using a time source
> that doesn't change speed along with the processor's clock speed.

I had the same problem with an AMD K6-2 on VIA Aladdin V chipset, and it 
WAS harmful, time source not sane at all, because the clock went at 
about half speed.

What worked for me: using Andrew Morton's kernel, it includes a 
via-tsc-fix.patch, now everything's all right.

Greetings,

Michael
