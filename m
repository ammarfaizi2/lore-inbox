Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269250AbRHQPA2>; Fri, 17 Aug 2001 11:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271650AbRHQPAR>; Fri, 17 Aug 2001 11:00:17 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:61660 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S269250AbRHQPAA>;
	Fri, 17 Aug 2001 11:00:00 -0400
Date: Fri, 17 Aug 2001 16:00:07 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Francois Romieu <romieu@cogenit.fr>, Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] Optionally let Net Devices feed Entropy
Message-ID: <1993180702.998064007@[10.132.112.53]>
In-Reply-To: <20010817110507.A25342@se1.cogenit.fr>
In-Reply-To: <20010817110507.A25342@se1.cogenit.fr>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> making it configurable.  Nothing is experimental.  This does not change
>> things; it makes things configurable.
>
> I have checked again the patches and they allow a lot of drivers to feed
> the entropy pool that otherwise wouldn't had ever contributed to it. Thus
> it changes things and opens the question about the effects on entropy
> estimate.

It only changes things if you configure it on, and you are correct that
many other drivers feed the entropy pool if so. That is, indeed, the whole
point of the patch.

> See the figures, three (3) nics to date reference
> SA_SAMPLE_RANDOM. As the fact that 2.4 is supposed to be a stable serie,
> I assume it's irrelevant.

There is a leap of logic in the last sentence I don't understand. Stable
(or rather release) kernels are supposed to behave predictably. Behaviour
dependent upon NIC is not predictable. Behaviour dependent upon a config
option (which does 'exactly what it says on the tin') is predictable.
Stable/release series are meant to have bugs fixed. Please tell me why
having 3 NIC cards behave one way, and the rest behaviour another is
/not/ a bug. Stable kernels are meant to be functional and secure. Robert's
patch allows the user both/either, in situations where the previous
kernel could be either dysfunctional (insufficient entropy) or arguably
potentially insecure (theoretical possibility of external manipulation
of entropy source).

--
Alex Bligh
