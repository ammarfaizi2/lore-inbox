Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132974AbRDRB5j>; Tue, 17 Apr 2001 21:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132973AbRDRB53>; Tue, 17 Apr 2001 21:57:29 -0400
Received: from m69-mp1-cvx1b.col.ntl.com ([213.104.72.69]:30368 "EHLO
	[213.104.72.69]") by vger.kernel.org with ESMTP id <S132972AbRDRB5J>;
	Tue, 17 Apr 2001 21:57:09 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        "'Pavel Machek'" <pavel@suse.cz>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <E14pgBe-0003gg-00@the-village.bc.nu>
From: John Fremlin <chief@bandits.org>
Date: 18 Apr 2001 02:56:56 +0100
In-Reply-To: Alan Cox's message of "Wed, 18 Apr 2001 01:51:12 +0100 (BST)"
Message-ID: <m2k84jkm1j.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

[...]

> I would tend to agree here. If you want to wire it to init the fine
> but pm is basically message passing kernel->user and possibly
> message reply to allow veto/approve. APM provides a good API for
> this and there is a definite incentive to make ACPI use the same
> messages, behaviour and extend it.

I'm wondering if that veto business is really needed. Why not reject
*all* APM rejectable events, and then let the userspace event handler
send the system to sleep or turn it off? Anybody au fait with the APM
spec?

This would have the advantage that the veto stuff could be ripped out
and things made simpler.

-- 

	http://www.penguinpowered.com/~vii
