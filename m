Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTEYSSV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 14:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTEYSSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 14:18:21 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:57873 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S261827AbTEYSSU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 14:18:20 -0400
Date: Sun, 25 May 2003 12:30:17 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Stephan von Krawczynski <skraw@ithnet.com>,
       Willy Tarreau <willy@w.ods.org>
cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-ID: <550410000.1053887417@aslan.scsiguy.com>
In-Reply-To: <20030525125811.68430bda.skraw@ithnet.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>	<2804790000.1052441142@aslan.scsiguy.com>
 	<20030509120648.1e0af0c8.skraw@ithnet.com>	<20030509120659.GA15754@alpha.home.local>	<20030509150207.3ff9cd64.skraw@ithnet.com>
 	<20030524111608.GA4599@alpha.home.local> <20030525125811.68430bda.skraw@ithnet.com>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Willy: I am willing to try a serial console setup (as it does not interfere
> with X).

Are you still running all of your tests with X up?  You then have no chance
of getting any useful diagnostics without a serial console.  Can't you switch
back to a vty while the test is running?

>I have tried this before with no luck. Can you provide some hints how
> you got that working (yes, I read Documentation/serial-console.txt, but
> I could not manage any output on the serial line).

You will need a null modem cable.  Config a kernel with serial console
support enabled.  Use a fairly high speed for your console (115200).  To
enable your first serial port as a console add something like the following
to your kenrel command line:

console=ttyS0,115200 console=vty0

This will retain console output on the vty too.

--
Justin

