Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbTIAKtS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 06:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbTIAKtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 06:49:18 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:49801 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262814AbTIAKtR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 06:49:17 -0400
Date: Mon, 1 Sep 2003 11:48:36 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Sam Creasey <sammy@sammy.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901104836.GA2202@mail.jlokier.co.uk>
References: <Pine.GSO.4.21.0309011027310.5048-100000@waterleaf.sonytel.be> <Pine.LNX.4.40.0309010632370.19846-100000@sun3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0309010632370.19846-100000@sun3>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Creasey wrote:
> 68020+Sun-3 MMU results attached below (this is for a 3/60, and it's not
> suprising that it passes, as there's no real cache in this configuration
> (the sun3/2xx did have external cache, but the onboard ethernet in my
> 3/210 is on the fritz, and it's not booting at the moment).  Note that
> this is the newer version of the program which Jamie just posted.

Thanks.

> bash-2.03# time ./jamie-test2
> (2048) [10000,10000,0] Test separation: 8192 bytes: pass

Mighty suspicious gettimeofday() you have there.

> real    1m34.330s
> user    1m30.030s
> sys     0m4.070s

Indeed, on other systems the test completes in a few seconds at most,
not because of CPU speed, but because gettimeofday() returns high
resolution time on them.

Isn't there a way to read high resolution time on the 68020 Sun-3?

-- Jamie
