Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264545AbUAJD10 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 22:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUAJD10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 22:27:26 -0500
Received: from adsl173-178.dsl.uva.nl ([146.50.173.178]:3225 "EHLO
	hypnos.var.cx") by vger.kernel.org with ESMTP id S264545AbUAJD1Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 22:27:25 -0500
Date: Sat, 10 Jan 2004 04:27:31 +0100
From: Frank v Waveren <fvw@var.cx>
To: Aaron Burt <aaron@speakeasy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALSA: bad sound with low CPU load
Message-ID: <20040110032731.GA16908@var.cx>
References: <slrnbvudvn.5ic.aaron@aluminum.bavariati.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnbvudvn.5ic.aaron@aluminum.bavariati.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 11:23:35PM +0000, Aaron Burt wrote:
> Basically, sound comes out as a hissing, garbled mess *unless* I load
> down the CPU.  A kernel compile seems to do nicely for this purpose.
Is it a garbled mess or a 1000Hz background tone? I get the latter on
the onboard audio of my A7N8X motherboard too, it's interference from
the timer interrupt. Not sure if it's power load related or EM
interference, but I strongly suspect it'll go away if you turn off
making idle calls in the kernel config. Going back to 100Hz (or up to
10000Hz as someone submitted a patch for a while back) will probably
make the problem go away too.

-- 
Frank v Waveren                                      Fingerprint: 9106 FD0D
fvw@[var.cx|stack.nl|dse.nl] ICQ#10074100               D6D9 3E7D FAF0 92D1
Public key: hkp://wwwkeys.pgp.net/8D54EB90              3931 90D6 8D54 EB90
