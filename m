Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTKCRL2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 12:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTKCRL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 12:11:28 -0500
Received: from h234n2fls24o1061.bredband.comhem.se ([217.208.132.234]:50399
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S262186AbTKCRL0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 12:11:26 -0500
Date: Mon, 3 Nov 2003 18:13:44 +0100
From: Voluspa <lista2@comhem.se>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS on 2.6.0-test9:
Message-Id: <20031103181344.64c57595.lista2@comhem.se>
In-Reply-To: <shssml5o2lp.fsf@charged.uio.no>
References: <20031103163455.57d24178.lista2@comhem.se>
	<shssml5o2lp.fsf@charged.uio.no>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First, pardon for the silly typo : that changed the subject.

On 03 Nov 2003 11:09:54 -0500
Trond Myklebust wrote:

> >>>>> " " == lista2  <Voluspa> writes:
> 
>      > Using TCP or DIRECTIO in -test9 makes no difference. Here's the
>      > relevant .config-section:
> 
> So where *does* the big jump from 3 minutes to 29 minutes occur? Are

Not a clue. Gave up on NFS when nothing had changed in -test4 and -test5
(the first regression). This weekend I spent compiling to find the
'readahead' values. Am on a PII 400, so takes time to nail specifics.
Can't do another marathon compile until next weekend.

> those numbers on TCP or are they UDP only?

Am rather clueless when it comes to networking. You have to deduce from
the following. Remote is a Pentium 120 with Slackware 7.1.0 (Universal
NFS Server 2.2beta47) kernel 2.2.16. Does it even speak TCP? I compiled
this -test9 with TCP only when I saw the 29 minutes - and no change
afterwards. Looks like I'm using UDP, or?

> What NIC are you using? From the error logs you showed us, it looked
> like it might be a de4x5 driver. Have you tried using the tulip
> driver?

On this -test9 it is an integrated NIC which needs the de4x5 (Compaq
Presario 5640). When trying out Slackware 9.something it was
autodetected as a tulip but didn't work with that driver. The P120 uses
an ISA card driven by a cs89x0 module.
 
> Are you using ACPI to set up the hardware? If so, does turning it off
> make a difference.

Kernels are compiled without everything in that area. Not even the older
power management is compiled in.
 
> Does 'netstat -s' offer any other hints?

As I said, clueless about networking. So I'll have to use the weekend
for more info-gathering.

Mvh
Mats Johannesson
