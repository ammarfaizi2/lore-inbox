Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270024AbUJNKzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270024AbUJNKzN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 06:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270026AbUJNKzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 06:55:13 -0400
Received: from relay.pair.com ([209.68.1.20]:52999 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S270024AbUJNKyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 06:54:50 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <416E5AF6.8080802@cybsft.com>
Date: Thu, 14 Oct 2004 05:54:46 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Schmidt <mista.tapas@gmx.net>
CC: Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       jackit-devel@lists.sourceforge.net
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>	<20041011215909.GA20686@elte.hu>	<20041012091501.GA18562@elte.hu>	<20041012123318.GA2102@elte.hu>	<20041012195424.GA3961@elte.hu>	<20041013061518.GA1083@elte.hu>	<20041014002433.GA19399@elte.hu>	<20041014105711.654efc56@mango.fruits.de>	<20041014091953.GA21635@elte.hu>	<20041014120007.01c26760@mango.fruits.de>	<15261.195.245.190.94.1097749350.squirrel@195.245.190.94> <20041014124845.5daecec2@mango.fruits.de>
In-Reply-To: <20041014124845.5daecec2@mango.fruits.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schmidt wrote:
> On Thu, 14 Oct 2004 11:22:30 +0100 (WEST)
> "Rui Nuno Capela" <rncbc@rncbc.org> wrote:
> 
> 
>>>Floating point exception
>>>
>>
>>This does not happen on my laptop.
>>
>>Testing also 2.6.9-rc4-mm1-U0, but a slightly custom jack 0.99.5 (cvs)
>>patched with "my" max_delayed_usecs suite.
>>
>>And jackd it's pumping while I'm writing this lines: jackd -R -d alsa,
>>against bundled crapsound (ali5451).
>>
>>My laptop is a P4 2.53Ghz, running on Mandrake 10.1c (gcc 3.4.1, glibc
>>2.3.3 NPTL).
> 
> 
> Hi,
> 
> hmm, it could, of course, be again debian's infamous glibc which bites me in
> the ass (as it did with ignoring pthread attributes (which still isn't fixed
> afaics)). Which direction should i go with investigating this further? I
> will build cvs jackd for a start.
> 
> flo
> 
> P.S.: attached is my .config

Or maybe this:

#
# Security options
#
# CONFIG_KEYS is not set
CONFIG_SECURITY=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_SECURITY_CAPABILITIES=m

For me, anything that needs to use setcap/getcap fails if I don't
compile in security capabilities ie. CONFIG_SECURITY_CAPABILITIES=y.
Don't know if this is your problem or not.

kr

