Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129865AbRCAU0K>; Thu, 1 Mar 2001 15:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbRCAUZ5>; Thu, 1 Mar 2001 15:25:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7048 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129865AbRCAUZ3>;
	Thu, 1 Mar 2001 15:25:29 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15006.44940.12004.57998@pizda.ninka.net>
Date: Thu, 1 Mar 2001 12:22:36 -0800 (PST)
To: Dan Malek <dan@mvista.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: The IO problem on multiple PCI busses
In-Reply-To: <3A9EAA2F.7C89C88@mvista.com>
In-Reply-To: <19350124090521.18330@mailhost.mipsys.com>
	<15006.40524.929644.25622@pizda.ninka.net>
	<3A9EA3FA.1A86893B@mvista.com>
	<15006.42475.79484.578530@pizda.ninka.net>
	<3A9EAA2F.7C89C88@mvista.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dan Malek writes:
 > It actually caused me to think of something else....I have cards
 > with multiple memory and I/O spaces (rare, but I have them).

So what?  All such bar's within mem/io space are part of unique
regions of the total MEM/IO space.

Thus you can pass non-conflicting offset/size pairs, based upon the
BAR value of interest, to mmap and everything is fine.

Later,
David S. Miller
davem@redhat.com
