Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293496AbSCEQ5b>; Tue, 5 Mar 2002 11:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293486AbSCEQ5W>; Tue, 5 Mar 2002 11:57:22 -0500
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:21120
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S293483AbSCEQ5J>; Tue, 5 Mar 2002 11:57:09 -0500
Date: Tue, 5 Mar 2002 08:56:24 -0800
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200203051656.g25GuO808431@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: "H. Peter Anvin" <hpa@zytor.com>, Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
In-Reply-To: <3C84F449.8090404@zytor.com>
In-Reply-To: <200203051443.JAA02111@ccure.karaya.com> <3C84F449.8090404@zytor.com>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Avin wrote:

> Jeff Dike wrote:
>
> > You think that UML refusing to run if it can't get every bit of memory it
> > might ever need is preferable to UML running fine in somewhat less memory?
> 
> Actually, yes, esp. since the only case you have been able to bring up is 
> one of the sysadmin being a moron.

I could easily imagine it being useful to run multiple UMLs on one
machine (to simulate a network, say), and that one's application
causes each UML to occasionally spike in its memory requirements.
Then it would be disappointing for the number of UMLs one could run to
be determined by this maximum memory requirement, rather than by the
average memory requirement (minus some leeway for a few spiking UMLs).

The hook Jeff asks for seems harmless enough.  If there is some
disagreement about how UML interacts with the host kernel on memory
allocation, the two different modes could be a configuration option of
UML.  The "touch it all at startup" option could be the default, as it
does make alot of sense for the single UML case.

Cheers,
Wayne
