Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264750AbUGBRET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbUGBRET (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 13:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUGBRET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 13:04:19 -0400
Received: from hera.cwi.nl ([192.16.191.8]:64670 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264750AbUGBRER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 13:04:17 -0400
Date: Fri, 2 Jul 2004 19:04:10 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       "K.G." <k_guillaume@libertysurf.fr>,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
Message-ID: <20040702170410.GC25914@apps.cwi.nl>
References: <s5gwu1mwpus.fsf@patl=users.sf.net> <Pine.LNX.4.21.0407021528150.21499-100000@mlf.linux.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0407021528150.21499-100000@mlf.linux.rulez.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 06:17:53PM +0200, Szakacsits Szabolcs wrote:

> Does anybody find the new HDIO_GETGEO semantic useful? Did it help
> _anything_? 

Yes. I do.

There was a steady stream of people reporting on geometry problems.
All these problems were caused by kernel guessing stuff.
If the kernel no longer volunteers a guess, then we no longer have
the situation that the guess can be wrong.

We lived in a world where things got more and more complicated
with programs guessing what values other programs might want
to satisfy a third program.

The new world is getting much simpler. Only the programs that need a value
have to invent it. Many of these can in fact do without. LILO survives
well without geometry information.

The only case I see where absolutely something is needed is the
case of partitioning an empty disk.
Telling the user at that point: "if you have no idea I'll use
H=255 S=63, that is very often correct, but note that if you also
want to use Windows on this disk it might be better to let Windows
partition first; also, enabling CONFIG_EDD might allow me to guess
what the BIOS uses" may be enough.

Andries
