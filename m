Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263745AbRGDLDR>; Wed, 4 Jul 2001 07:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264023AbRGDLDH>; Wed, 4 Jul 2001 07:03:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18191 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263745AbRGDLC6>; Wed, 4 Jul 2001 07:02:58 -0400
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
To: david.woolley@bts.co.uk (Dave J Woolley)
Date: Wed, 4 Jul 2001 12:03:07 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'), andrew.grover@intel.com,
        jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, acpi@phobos.fachschaften.tu-muenchen.de
In-Reply-To: <81E4A2BC03CED111845100104B62AFB50102A7FD@stagecoach.bts.co.uk> from "Dave J Woolley" at Jul 04, 2001 11:37:00 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15HkR1-0000lb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I argued this at the very beginning, but there was a very strong
> view that you needed to run most of the code before you had a user
> space to run it in.  I've not followed things closely enough to 

That bit is clearly untrue.

> My feeling has been that ACPI has violated the minimum privilege
> concept from the beginning, although I think putting stuff in drivers
> that could be at user level is not htat uncommon in Linux.

It still seems to lack even basic checks that the writes AML does are into
E820 NV or device space only - also while fixing it the ACPI guys might note
that a write close to 0xFFFFFFFF will lead to a failed ioremap and a nasty
mess because they ioremap a fixed sized window that will wrap



