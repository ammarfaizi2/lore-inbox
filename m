Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267744AbSLTF7P>; Fri, 20 Dec 2002 00:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267745AbSLTF7P>; Fri, 20 Dec 2002 00:59:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5129 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267744AbSLTF7O>; Fri, 20 Dec 2002 00:59:14 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: PATCH 2.5.x disable BAR when sizing
Date: Fri, 20 Dec 2002 06:05:29 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <atubv9$69s$1@penguin.transmeta.com>
References: <20021219213712.0518B12CB2@debian.cup.hp.com> <1040352868.30778.12.camel@irongate.swansea.linux.org.uk> <15874.32773.829438.109509@napali.hpl.hp.com>
X-Trace: palladium.transmeta.com 1040364433 14794 127.0.0.1 (20 Dec 2002 06:07:13 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 20 Dec 2002 06:07:13 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <15874.32773.829438.109509@napali.hpl.hp.com>,
David Mosberger  <davidm@napali.hpl.hp.com> wrote:
>  Alan> And yes this happens on some PC class systems.
>
>And yet it's OK to remap that memory?  That seems unlikely.

Alan is right, however "unlikely" you think it is. 

Turning off stuff in the config register not only turns off the standard
BAR's, it can turn off _everything_.  Including stuff that isn't even
covered by the standard BARs that are beng probed. 

It's like shutting off the power for the whole house because you want to
change a lightbulb.  Sure, it's safer for the lightbulb, but if you
don't know what -else- needs power in the house, it sure as hell isn't
a good idea. Maybe you just trashed your wifes work because she happened
to be in front of the computer when you turned off the lights.

		Linus
