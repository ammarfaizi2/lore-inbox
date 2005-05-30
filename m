Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVE3SZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVE3SZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVE3SZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:25:22 -0400
Received: from mx2.elte.hu ([157.181.151.9]:16852 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261676AbVE3SWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:22:39 -0400
Date: Mon, 30 May 2005 20:22:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Pekka Enberg <penberg@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM] Machine Freezes while Running Crossover Office
Message-ID: <20050530182207.GA8111@elte.hu>
References: <1117291619.9665.6.camel@localhost> <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org> <84144f0205052911202863ecd5@mail.gmail.com> <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org> <1117399764.9619.12.camel@localhost> <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org> <1117466611.9323.6.camel@localhost> <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org> <FC5325FE-7730-4A66-BDA8-B6C035E6276F@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FC5325FE-7730-4A66-BDA8-B6C035E6276F@mac.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Kyle Moffett <mrmacman_g4@mac.com> wrote:

> On May 30, 2005, at 13:31:07, Linus Torvalds wrote:
> >On Mon, 30 May 2005, Pekka Enberg wrote:
> >>It is not just X. Running the following shell script when hitting the
> >>bug:
> >
> >Ok, this implies that the scheduler is really screwed up, we're not
> >scheduling anything else during that time.
> 
> If X is hung and not accepting data on any of its sockets, then this 
> could hang the Xterm in the background, and therefore hang the 
> printout from the "date" process.  What happens if you do this?
> 
> Switch to VT 1:
> # while true; do date; sleep 1; done
> 
> Switch to X and trigger hang
> 
> Switch back to VT 1 and look at output

yes, this would be an important test. Even better, do:

	while true; do date; sleep 1; done > log.txt

to exclude any sort of console output as a source of delay.

	Ingo
