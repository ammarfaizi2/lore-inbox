Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131480AbRC3Pyi>; Fri, 30 Mar 2001 10:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131481AbRC3Py2>; Fri, 30 Mar 2001 10:54:28 -0500
Received: from arbi.informatik.uni-oldenburg.de ([134.106.1.7]:53520 "EHLO
	arbi.Informatik.Uni-Oldenburg.DE") by vger.kernel.org with ESMTP
	id <S131480AbRC3PyS>; Fri, 30 Mar 2001 10:54:18 -0500
From: "Jochen Hoenicke" <Jochen.Hoenicke@Informatik.Uni-Oldenburg.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15044.44025.622115.778319@huxley.Informatik.Uni-Oldenburg.DE>
Date: Fri, 30 Mar 2001 17:53:29 +0200 (MET DST)
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: Bug in EZ-Drive remapping code (ide.c)
In-Reply-To: <UTC200103301115.NAA61753.aeb@vlet.cwi.nl>
In-Reply-To: <UTC200103301115.NAA61753.aeb@vlet.cwi.nl>
X-Mailer: VM 6.75 under 20.0 XEmacs Lucid (beta28)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 30, Andries.Brouwer@cwi.nl wrote:
> So yes, the problem is known, but I do not see a clean solution,
> unless the solution is to rip out all this EZ drive nonsense.

Grub can already handle EZ drives itself so this would be a solution :)
However, fdisk depends on the remapping.

> (I can well imagine that this would happen in 2.5:
> the task of the IDE driver is to transport bits from and to
> the disk, not to worry about the contents.)
> And even if it were fixed somehow in a 2.4 kernel, lots of
> people will have a 2.2 or older system for quite some time
> to come. So probably grub should regard this as a quirk in
> the Linux handling of disks with EZ drive and adapt
> (that is, read sector 0, and then read sectors 1-N,
> but do not read 0-N).

I make a patch for grub to do that.  

  Jochen
