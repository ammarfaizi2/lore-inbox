Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbTKJLFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 06:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbTKJLFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 06:05:34 -0500
Received: from intra.cyclades.com ([64.186.161.6]:27024 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263166AbTKJLF0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 06:05:26 -0500
Date: Mon, 10 Nov 2003 08:58:18 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: Some thoughts about stable kernel development
In-Reply-To: <m3u15de669.fsf@defiant.pm.waw.pl>
Message-ID: <Pine.LNX.4.44.0311100851190.16790-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 9 Nov 2003, Krzysztof Halasa wrote:

> Hi,
> 
> There is no doubt any development model has some problems, and ours
> can't be an exception. I'd like to share with you an idea which
> recently found a way to my mind.
> 
> There is a problem that a development cycle (time between stable
> = non-pre/rc versions) is long. Imagine a situation when we are at
> some pre-3 stage, the kernel tree is full of problems which must be
> resolved before the final release, and some serious security-class
> bug has been found. We would be unable to have a secured stable
> version shortly unless the maintainer checks through all changes to
> last stable kernel, identify fixes which are both safe and necessary
> (hopefully there are no necessary unsafe ones at that time), and
> back-out everything else. Such a scenario is real and that way we might
> end up with official kernel being unusable for any Internet-connected
> tasks for weeks.
> 
> Here is what I propose:
> As all of you know, the development cycle can be shortened by using
> two separate trees for a stable kernel line.
> 
> Say, we're now at 2.4.23-rc1 stage. This "rc" kernel would also be
> known as 2.4.24-pre1. The maintainer would apply "rc"-class fixes to
> both kernels, and other patches (which can't go to "rc" kernel) would
> be applied to 2.4.24-pre1 only.
> 
> After 2.4.23-rcX becomes final 2.4.23, the 2.4.24-preX would become
> 2.4.24-rc1 and would be a base for 2.4.25-pre1.

I really dont understand this "be a base for 2.4.25-pre1".

I guess what you mean is you want a separate 2.4.24-pre tree accepting 
"-pre" patches while 2.4.23-rc is "in stage" accepting critical bugfixes 
only.

That would be useful yes. Maybe Andrew should do it in 2.6 ?


