Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbREMOXW>; Sun, 13 May 2001 10:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261408AbREMOXM>; Sun, 13 May 2001 10:23:12 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:51211 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S261407AbREMOXH>;
	Sun, 13 May 2001 10:23:07 -0400
To: esr@thyrsus.com
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
In-Reply-To: <20010505192731.A2374@thyrsus.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 13 May 2001 16:22:59 +0200
In-Reply-To: "Eric S. Raymond"'s message of "Sat, 5 May 2001 19:27:31 -0400"
Message-ID: <d33da9tjjw.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Eric" == Eric S Raymond <esr@thyrsus.com> writes:

Eric> I've said before on these lists that one of the purposes of
Eric> CML2's single-apex tree design is to move the configuration
Eric> dialog away from low-level platform- specific questions towards
Eric> higher-level questions about policy or intentions.

Eric> Or to put another way: away from hardware, towards capabilities.

Eric> As a concrete example, the CML2 rulesfile master for the m68k
Eric> port tree now has a section that looks like this:

Eric> # These were separate questions in CML1.  They enable on-board
Eric> peripheral # controllers in single-board computers.  derive
Eric> MVME147_NET from MVME147 & NET_ETHERNET derive MVME147_SCC from
Eric> MVME147 & SERIAL derive MVME147_SCSI from MVME147 & SCSI derive
Eric> MVME16x_NET from MVME16x & NET_ETHERNET derive MVME16x_SCC from
Eric> MVME16x & SERIAL derive MVME16x_SCSI from MVME16x & SCSI derive
Eric> BVME6000_NET from BVME6000 & NET_ETHERNET derive BVME6000_SCC
Eric> from BVME6000 & SERIAL derive BVME6000_SCSI from BVME6000 & SCSI

Not all cards have all features, not all users wants to enable all
features.

Eric> # These were separate questions in CML1 derive MAC_SCC from MAC
Eric> & SERIAL derive MAC_SCSI from MAC & SCSI derive SUN3_SCSI from
Eric> (SUN3 | SUN3X) & SCSI

As Alan already pointed out thats assumption is invalid.

Eric> This is different from the CML1 approach, which generally
Eric> involved explicitly specifying each driver with mutual
Eric> dependencies described (if at all) in Configure.help.

Yes and it should stay like that. If Richard had wanted all those
features enabled per default when an MVME setting was selected, he
would have done it in the config.in file, which is perfectly valid to
do so today.

Eric> This note is a heads-up.  If others with a stake in the
Eric> configuration system (port managers, etc.) have objections to
Eric> moving further in this direction, I need to hear about it, and
Eric> about what you think we should be doing instead.  -- <a
Eric> href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Yes I have objections. I thought I had made this clear a long time
ago: Go play with another port and leave the m68k port alone.

Thank you
Jes
