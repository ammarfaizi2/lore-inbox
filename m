Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbULGUgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbULGUgJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 15:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbULGUgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 15:36:09 -0500
Received: from mail.convergence.de ([212.227.36.84]:34279 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S261914AbULGUgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 15:36:04 -0500
Message-ID: <41B613E1.2010602@linuxtv.org>
Date: Tue, 07 Dec 2004 21:34:41 +0100
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Michael Hunold <hunold@convergence.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Johannes Stezenbach <js@convergence.de>
Subject: Re: Linux 2.6.10-rc3 oops when 'modprobe -r dvb-bt8xx'
References: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org>	<41B1BD24.4050603@eyal.emu.id.au> <87653ex9wy.fsf@bytesex.org>
In-Reply-To: <87653ex9wy.fsf@bytesex.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 12/07/04 19:03, Gerd Knorr schrieb:
> I somehow feel the best way to deal with that is to merge the
> redesigned frontend handing pending in -mm at the moment into Linus
> tree _now_, that should kill that whole class of bugs.

Johannes and I had agreed with Andrew that the redesigned frontend code 
should stay in -mm for now, because we expect that support for some 
cards is broken. We currently don't receive very much reports on the 
mailing list though.

> That may result in the dvb subsystem not being that stable in 2.6.10.
> But dvb not being rock solid in 2.6.10 will very likely happen anyway
> as the code currently in Linus' tree isn't very stable as well.  I
> think the chance that it gets even worse is small enougth that we can
> take the risk.
> 
> Additional bonus would be that we don't get bugreports for the old
> code base which is already obsolete (and nobody wants to work on
> because of that).
> 
> Michael?

I just spoke to Johannes and we agree with you, Gerd. The DVB changes 
can and should be merged from -mm now. There is a fair chance that the 
remaining issues with broken cards can be resolved before 2.6.10.

The code is in a good shape and only some small patches are missing from 
the LinuxTV.org CVS.

I can prepare a patch that fixes the support for some cards and other 
minor improvements tomorrow.

>   Gerd

CU
Michael.
