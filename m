Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265054AbUGGLPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbUGGLPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 07:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265055AbUGGLPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 07:15:22 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:60607 "EHLO scrub.home")
	by vger.kernel.org with ESMTP id S265054AbUGGLPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 07:15:17 -0400
Date: Wed, 7 Jul 2004 13:14:33 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
cc: Szakacsits Szabolcs <szaka@sienet.hu>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andries Brouwer <aebr@win.tue.nl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Clausen <clausen@gnu.org>,
       buytenh@gnu.org, msw@redhat.com
Subject: Re: Restoring HDIO_GETGEO semantics for 2.6 (was: Re: [RFC] Restoring
 HDIO_GETGEO semantics)
In-Reply-To: <20040707012856.GA1481@apps.cwi.nl>
Message-ID: <Pine.LNX.4.58.0407071304190.20635@scrub.home>
References: <20040706015620.GA12659@apps.cwi.nl>
 <Pine.LNX.4.21.0407061811090.4511-100000@mlf.linux.rulez.org>
 <20040707012856.GA1481@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 7 Jul 2004, Andries Brouwer wrote:

> How does a monster like that arise? Wart upon wart. Well, we guess, and
> usually right, but not always, then invent a correction to guess a bit
> better in some special situations, then ...
> And times change, and likely guesses become less likely, and changes are made ...
> 
> At some point in time the monster must be eliminated.
>
> [..]
> 
> Now this happened first in 2.5.6 if I recall correctly, over two
> years ago, and a few programs had to be adapted a little.
> I think fdisk, cfdisk, sfdisk, probably also lilo, were adapted rather
> quickly, but, as we discovered recently, parted took more time. Ach.

I basically agree with your argumentation, but it wasn't really eliminated 
in 2.5.6. The kernel still provides some values to the users. If the 
kernel doesn't know, it should clearly say so, this is where we fucked up. 
Silently fixing a few applications and leaving everybody else believing 
everything is well doesn't help.
At this point we either complete the job and remove this ioctl or we 
restore the 2.4 behaviour (maybe with a deprecated warning).

bye, Roman
