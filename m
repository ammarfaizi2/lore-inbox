Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264695AbTIDFJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 01:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264667AbTIDFJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 01:09:49 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:27819 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264695AbTIDFJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 01:09:48 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 3 Sep 2003 22:03:59 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
cc: Jamie Lokier <jamie@shareable.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Kars de Jong <jongk@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <Pine.LNX.4.44.0309032134040.25093-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.56.0309032200010.2146@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.44.0309032134040.25093-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Nagendra Singh Tomar wrote:

> Jamie,
> 	Just wondered if the store buffer is snooped in some
> architectures. In that case I believe the OS need not do anything for
> serialization (except for aliases, if they do not hit the same cache line).
> In x86 store buffer is not snooped which leads to all these serialization
> issues (other CPUs looking at stale value of data which is in the store
> buffer of some other CPU).
> Pl correct me if I have got anything wrong/

To avoid the so called 'load hazard' (that, BTW, triggers read over
writes, that are not allowed in x86) you have two options. Snoop the write
buffer or flush it upon L1 miss. Otherwise you might end up getting stale
data from L2.



- Davide

