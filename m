Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbTH1NJv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 09:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264074AbTH1NJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 09:09:51 -0400
Received: from janus.zeusinc.com ([205.242.242.161]:19992 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S264073AbTH1NJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 09:09:45 -0400
Subject: Re: Poor IPSec performance with 2.6 kernels
From: Tom Sightler <ttsig@tuxyturvy.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: jmorris@intercode.com.au, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200308281016.h7SAGKi24571@freya.yggdrasil.com>
References: <200308281016.h7SAGKi24571@freya.yggdrasil.com>
Content-Type: text/plain
Message-Id: <1062076162.1907.21.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 28 Aug 2003 09:09:23 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	In which direction did you take these benchmarks, inbound to the
> Linux box, outbound from the Linux box, or both?  If both, is
> there a difference between inbound and outbound performance?  What
> private key algorithm are you configuring (aes, des, serpent)?  How
> is your DSL connected (via ethernet, via USB, such as with SpeedStream)?
> What kind of CPU are you using (probably doesn't matter, even if you're
> using a 16MHz 386, but it would help in reproducing your problem to
> know what the benchmarks should look like on a different system).

Unfortunately my DSL service is ADSL and my uplink is only 256Kbps which
gives me about 25-30KB/s on a typical, non-IPsec FTP upload.  Both SFS
and in-kernel IPsec give approximately the same outbound speed over this
limited link, roughly 20KB/s, which seems about right to me.

I'm using 3des for the encryption algorithm.

DSL is connected via ethernet.

CPU is an AMD K6/2 333Mhz.

I also just thought about the fact that I could test my laptop to see if
this is a CPU related issue.  It's running the same basic kernel but of
course with options for laptop devices enabled and compiled for i686,
etc.  It's a much faster machine, a PIII/1.13Ghz system.  If I still get
roughly the same performance then we can probably safely assume it's not
a CPU constraint.  I'll test the tonight.

I'm also going to try and pull some TCP dump data to see if it gives me
any hints.

Anything else I can answer.

Later,
Tom



