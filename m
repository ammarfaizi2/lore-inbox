Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267620AbTGHUnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 16:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267626AbTGHUnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 16:43:52 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:20367 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S267620AbTGHUnu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 16:43:50 -0400
Date: Tue, 8 Jul 2003 21:58:09 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Gerald Britton <gbritton@alum.mit.edu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, emperor@EmperorLinux.com,
       LKML <linux-kernel@vger.kernel.org>,
       EmperorLinux Research <research@EmperorLinux.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Linux and IBM : "unauthorized" mini-PCI : Cisco mpi350 _way_ sub-optimal
Message-ID: <20030708205809.GA18307@mail.jlokier.co.uk>
References: <1054658974.2382.4279.camel@tori> <20030610233519.GA2054@think> <200307071412.00625.durey@EmperorLinux.com> <1057672948.4358.20.camel@dhcp22.swansea.linux.org.uk> <20030708112016.A10882@light-brigade.mit.edu> <1057678950.4358.53.camel@dhcp22.swansea.linux.org.uk> <20030708132417.B10882@light-brigade.mit.edu> <20030708184421.A13083@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030708184421.A13083@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Definitely not yet, since x86 has a policy of not reallocating anything
> at all.  I suspect getting it to handle it will open a huge live mine
> field, full of SMI ports. 8(
> 
> Any x86 PCI gurus got any ideas?

You may be able to identify devices which are very unlikely to be
touched by the SMI handler, and just allow those to be moved.
E.g. video cards, USB, IDE, "system", ISA bridge etc. may all be
touched by the SMI (for power management), but the sound, modem and
network are much less unlikely.

Ok, it's flailing a bit...

-- Jamie
