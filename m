Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbTHZSuy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 14:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbTHZSuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 14:50:54 -0400
Received: from pirx.hexapodia.org ([208.42.114.113]:33801 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S262822AbTHZSuw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 14:50:52 -0400
Date: Tue, 26 Aug 2003 13:50:51 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: max@vortex.physik.uni-konstanz.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 shocking (HT) benchmarking (wrong logic./phys. HT CPU distinction?)
Message-ID: <20030826135051.A16285@hexapodia.org>
References: <200308261552.44541.max@vortex.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200308261552.44541.max@vortex.physik.uni-konstanz.de>; from max@vortex.physik.uni-konstanz.de on Tue, Aug 26, 2003 at 03:52:44PM +0200
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003, max@vortex.physik.uni-konstanz.de wrote:
> in our fine physics group we recently bought a DUAL XEON P4 2666MHz, 2GB, with
> hyper-threading support and I had the honour of making the thing work. In the 
> process I also did some benchmarking using two different kernels (stock 
> SuSE-8.2-Pro 2.4.20-64GB-SMP, and the latest and greatest vanilla 
> 2.6.0-test4). I benchmarked 
> 
> [2] running time of a multi-threaded numerical simulation making extensive use
> of FFTs, using the fftw.org library.

One thing to watch out for, with fftw:  I believe it will benchmark
various kernels, and decide which one to use, at run-time.  If the
scheduler fools it into thinking that a particular kernel is going to
perform better, it might do the wrong thing.

Does fftw have a switch to write a debug log?

("kernel" in this context means "the small section of code used to solve
the fft", not "the OS code running in privileged mode".)

-andy
