Return-Path: <linux-kernel-owner+w=401wt.eu-S932945AbWL0Okt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932945AbWL0Okt (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 09:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932940AbWL0Okt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 09:40:49 -0500
Received: from web32603.mail.mud.yahoo.com ([68.142.207.230]:41705 "HELO
	web32603.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932857AbWL0Oks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 09:40:48 -0500
X-YMail-OSG: SpUxHSEVM1nXbh1KxL0cHHKyl6i8.mLUFhK5Fz7RMMyJcB0pcMBZ_F79NrMwwwlW6g717QneVzNYQnA.hLitUnwxw9npVeZ.uRJCLLrdx9gu9EhsG.tmeg--
X-RocketYMMF: knobi.rm
Date: Wed, 27 Dec 2006 06:40:47 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: How to detect multi-core and/or HT-enabled CPUs in 2.4.x and 2.6.x kernels
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1167229470.3281.3905.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <927934.92732.qm@web32603.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Arjan van de Ven <arjan@infradead.org> wrote:

> On Wed, 2006-12-27 at 06:16 -0800, Martin Knoblauch wrote:
> > Hi, (please CC on replies, thanks)
> > 
> >  for the ganglia project (http://ganglia.sourceforge.net/) we are
> > trying to find a heuristics to determine the number of physical CPU
> > "cores" as opposed to virtual processors added by enabling HT. The
> > method should work on 2.4 and 2.6 kernels.
> 
> I have a counter question for you.. what are you trying to do with
> the
> "these two are SMT sibblings" information ?
> 
> Because I suspect "HT" is the wrong level of detection for what you
> really want to achieve....
> 
> If you want to decide "shares caches" then at least 2.6 kernels
> directly
> export that (and HT is just the wrong way to go about this). 
> -- 
Hi Arjan,

 one piece of information that Ganglia collects for a node is the
"number of CPUs", originally meaning "physical CPUs". With the
introduction of HT and multi-core things are a bit more complex now. We
have decided that HT sibblings do not qualify as "real" CPUs, while
multi-cores do.

 Currently we are doing "sysconf(_SC_NPROCESSORS_ONLN)". But this
includes both physical and virtual (HT) cores. We are looking for a
method that only shows "real iron" and works on 2.6 and 2.4 kernels.
Whether this has any practial valus is a completely different question.

Cheers
Martin

------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
