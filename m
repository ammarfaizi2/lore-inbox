Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVABDH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVABDH7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 22:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVABDH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 22:07:59 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:26893 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261230AbVABDH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 22:07:57 -0500
Date: Sun, 2 Jan 2005 04:07:53 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Andries Brouwer <aebr@win.tue.nl>, Bodo Eggert <7eggert@gmx.de>,
       Fryderyk Mazurek <dedyk@go2.pl>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       gustavo@compunauta.com
Subject: Re: [ide] ide-disk: enable stroke by default - was Re: Problems with 2.6.10
Message-ID: <20050102030753.GF2818@pclin040.win.tue.nl>
References: <fa.b02ekp9.12i8ti1@ifi.uio.no> <fa.ekat19o.emk580@ifi.uio.no> <E1CktTx-0003bC-00@be1.7eggert.dyndns.org> <20050102010434.GE2818@pclin040.win.tue.nl> <20050102024451.GA7893@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050102024451.GA7893@ime.usp.br>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: SINECTIS: pastinakel.tue.nl 1114; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 12:44:51AM -0200, Rogério Brito wrote:
> On Jan 02 2005, Andries Brouwer wrote:
> > That is, we used to have "stroke", but we want to have "nostroke".
> 
> What exactly does "stroke" mean? The description in the help file is a bit
> cryptic for a layman.

It is possible to set the size of the disk to something smaller than
its actual size, either temporarily (can be undone at will) or permanently
(valid until the next reboot). It is also possible to attach a password
to this change.

One of the reasons is that people want to have code or data at the end
of the disk (operating system, diagnostics, backup, other) that the user
cannot tamper with.

But the existence of BIOSes that cannot handle large disks gives another
use of this "setmax" operation: make the disk appear smaller at the time
the BIOS looks at it, and give it full size under Linux.

Now that I think about it - the originator of this thread had problems
rebooting with the full-size disk since his BIOS didnt like it.
Instead of using a kernel boot option "nostroke", it is possible that
he could use my utility setmax at reboot time to make the disk smaller again.
That would allow use of the full disk under Linux.

Andries


