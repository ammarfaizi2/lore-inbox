Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbTFCTDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 15:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTFCTDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 15:03:05 -0400
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:16605 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id S262444AbTFCTDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 15:03:03 -0400
Date: Tue, 3 Jun 2003 20:11:54 +0100
From: Stig Brautaset <stig@brautaset.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange dependancy generation bug?
Message-ID: <20030603191154.GA30323@brautaset.org>
References: <fa.er84418.1ikmjqq@ifi.uio.no> <fa.hfbafvn.n7qkih@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa.hfbafvn.n7qkih@ifi.uio.no>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 03 2003, Sam wrote:
... 
> But the real question is why you start seeing the invocation
> of fixdep. I do not see it on my machine.
> I asssume that you see fixdep invocation even with "make V=0".
> This is a bug!
> 
> Counting this one I have now three independent reports where
> kbuild displayed the invocation of fixdep.
> 
> I have tried to narrow down the root cause.
> Both users were running debian unstable.
> Different shells.
> GNU make 3.80
> 
> I tried to install GNU make 3.80 - but I still do not see the problem.
> What happens is that within Makefile.build there is used multi line
> definition, where each new-line causes make to launch a new sub-shell.
> The command for the second sub-shell is echoed, even though make is told
> not to do so. 

I beg to differ. Since make launches a new subshell, the commands in the
second subshell is _not_ told to shut up, and thus is echoed. No?


Stig
-- 
brautaset.org
