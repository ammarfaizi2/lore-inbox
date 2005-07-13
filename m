Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbVGMMfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbVGMMfi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 08:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVGMMfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 08:35:37 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:22181 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262610AbVGMMfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 08:35:32 -0400
Date: Wed, 13 Jul 2005 14:35:29 +0200
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: synaptics touchpad not recognized by Xorg X server with recent -mm kernels
Message-ID: <20050713123529.GA13397@gamma.logic.tuwien.ac.at>
References: <20050712172504.GD24820@gamma.logic.tuwien.ac.at> <m3fyujq5cf.fsf@telia.com> <20050712201121.GA5587@gamma.logic.tuwien.ac.at> <m364vfpsul.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m364vfpsul.fsf@telia.com>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mit, 13 Jul 2005, Peter Osterlund wrote:
> Looks correct. My guess is that something is wrong with your device
> nodes. What's the output from "ls -l /dev/input/event*"?

Bingo. THere was no event0 and event1, although the evdev module was
loaded!

I had to unload evdev and reload it again to get the event devices.

Seems to be either a bug in evdev or in udev.

Sorry for the noise. Whom should I ask now?

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining AT logic DOT at>             Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
The major difference between a thing that might go wrong
and a thing that cannot possibly go wrong is that when a
thing that cannot possibly go wrong goes wrong it usually
turns out to be impossible to get at or repair.
                 --- One of the laws of computers and programming revealed.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
