Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262124AbREPXHm>; Wed, 16 May 2001 19:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262126AbREPXHc>; Wed, 16 May 2001 19:07:32 -0400
Received: from intranet.resilience.com ([209.245.157.33]:7564 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S262124AbREPXHX>; Wed, 16 May 2001 19:07:23 -0400
Mime-Version: 1.0
Message-Id: <p05100306b728b73efd94@[10.128.7.49]>
In-Reply-To: <3B02F30F.5D05C77E@mandrakesoft.com>
In-Reply-To: <6B1DF6EEBA51D31182F200902740436802678ED4@mail-in.comverse-in.com>
 <3B02F30F.5D05C77E@mandrakesoft.com>
Date: Wed, 16 May 2001 16:06:51 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: ((struct pci_dev*)dev)->resource[...].start
Cc: LINUX Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 5:37 PM -0400 2001-05-16, Jeff Garzik wrote:
>This is not a safe assumption, because the OS may reprogram the PCI BARs
>at certain times.  The rule is:  ALWAYS read from dev->resource[] unless
>you are a bus driver (PCI bridges, for example, need to assign
>resources).

Would you please elaborate? If I understand what you're saying, you 
can't rely on the "pointer" returned by ioremap() because the OS 
might reprogram the relevant BAR out from under you. So one would 
need to know: when does a driver have to re-ioremap() due to the BAR 
having been (potentially) changed? I'd expect the answer to be: for 
all practical purposes never.

-- 
/Jonathan Lundell.
