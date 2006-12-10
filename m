Return-Path: <linux-kernel-owner+w=401wt.eu-S1760419AbWLJIG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760419AbWLJIG2 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 03:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760460AbWLJIG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 03:06:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:43447 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760406AbWLJIG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 03:06:27 -0500
Subject: Re: powerpc: "IRQ probe failed (0x0)" on powerbook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Collins <paul@briny.ondioline.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
In-Reply-To: <87lklg9rkz.fsf@briny.internal.ondioline.org>
References: <87lklg9rkz.fsf@briny.internal.ondioline.org>
Content-Type: text/plain
Date: Sun, 10 Dec 2006 19:06:10 +1100
Message-Id: <1165737970.1103.171.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-10 at 19:45 +1300, Paul Collins wrote:
> On my PowerBook when booting Linus's tree as of commit af1713e0 I get
> something like this:
> 
>   [blah blah]
>   ide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 0
>   Probing IDE interface ide0...
>   hda: HTS541080G9AT00, ATA DISK drive
>   IRQ probe failed (0x0)
>   IRQ probe failed (0x0)
>   IRQ probe failed (0x0)
>   IRQ probe failed (0x0)
> 
> And then of course it fails to mount root.  No such problem using a
> kernel built from commit 97be852f of December 2nd.

I'll investigate tomorrow, looks like irq assignment got broken in a way
or another for that IDE controller.

Ben.


