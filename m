Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132784AbRDRBEU>; Tue, 17 Apr 2001 21:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132940AbRDRBEL>; Tue, 17 Apr 2001 21:04:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27411 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132784AbRDRBDz>; Tue, 17 Apr 2001 21:03:55 -0400
Subject: Re: Let init know user wants to shutdown
To: andrew.grover@intel.com (Grover, Andrew)
Date: Wed, 18 Apr 2001 01:51:12 +0100 (BST)
Cc: chief@bandits.org ('John Fremlin'),
        linux-power@phobos.fachschaften.tu-muenchen.de ("Acpi-PM (E-mail)"),
        pavel@suse.cz ('Pavel Machek'),
        Simon.Richter@phobos.fachschaften.tu-muenchen.de (Simon Richter),
        aferber@techfak.uni-bielefeld.de (Andreas Ferber),
        linux-kernel@vger.kernel.org
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDD91@orsmsx35.jf.intel.com> from "Grover, Andrew" at Apr 17, 2001 05:07:30 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pgBe-0003gg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There should be only one PM policy agent on the system. I don't care about
> other processes that query for display purposes, but someone needs to be

The kernel pm code assumes there is a single agent issuing power management
requests via pm_* calls. User space is a different matter. There are numerous
good arguments for multiple policy agents, be they multiple applications or
multiple state machines in one system. Most power management seems to best
be modelled by multiple very simple algorithms running in parallel.

> solution, but I hope I have been able to be clear on why I believe an actual
> daemon is justified. 

I would tend to agree here. If you want to wire it to init the fine but 
pm is basically message passing kernel->user and possibly message reply to
allow veto/approve. APM provides a good API for this and there is a definite
incentive to make ACPI use the same messages, behaviour and extend it. 


