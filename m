Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVA1SSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVA1SSv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVA1SSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:18:51 -0500
Received: from hera.kernel.org ([209.128.68.125]:13451 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261520AbVA1SSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:18:39 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
Date: Fri, 28 Jan 2005 10:18:25 -0800
Organization: Open Source Development Lab
Message-ID: <20050128101825.388990a0@dxpl.pdx.osdl.net>
References: <1106932637.3778.92.camel@localhost.localdomain>
	<20050128174046.GR28047@stusta.de>
	<1106934475.3778.98.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
X-Trace: build.pdx.osdl.net 1106936298 3049 172.20.1.103 (28 Jan 2005 18:18:18 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Fri, 28 Jan 2005 18:18:18 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 0.9.13 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by hera.kernel.org id j0SIIOJD026075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 18:47:55 +0100
Lorenzo Hernández García-Hierro <lorenzo@gnu.org> wrote:

> El vie, 28-01-2005 a las 18:40 +0100, Adrian Bunk escribió:
> > On Fri, Jan 28, 2005 at 06:17:17PM +0100, Lorenzo Hernández García-Hierro wrote:
> > >...
> > > As it's impact is minimal (in performance and development/maintenance
> > > terms), I recommend to merge it, as it gives a basic prevention for the
> > > so-called system fingerprinting (which is used most by "kids" to know
> > > how old and insecure could be a target system, many time used as the
> > > first, even only-one, data to decide if attack or not the target host)
> > > among other things.
> > >...
> > 
> > "basic prevention"?
> > I hardly see how this patch makes OS fingerprinting by e.g. Nmap 
> > impossible.
> 
> That's an example, as you can find at the grsecurity handbook [1]:
> 
> "The default Linux TCP/IP-stack has some properties that make it more
> vulnerable to prediction-based hacks. By randomizing several items,
> predicting the behaviour will be a lot more difficult."

No it just changes the fingerprint table.  "Hmm, this looks like a
newer generation system, must be OpenBSD or Linux".

> "Randomized IP IDs hinders OS fingerprinting and will keep your machine
> from being a bounce for an untraceable portscan."
> 
> References:
>  [1]: http://www.gentoo.org/proj/en/hardened/grsecurity.xml

This is a very transitory effect, it works only because your machine
is then different from the typical Linux machine; therefore the scanner
will go on to the next obvious ones. But if this gets incorporated widely
then the rarity factor goes away and this defense becomes useless.

-- 
Stephen Hemminger	<shemminger@osdl.org>

