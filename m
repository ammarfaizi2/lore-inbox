Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268364AbTGOSJd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269354AbTGOSJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:09:33 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:50846 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S268364AbTGOSIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:08:15 -0400
Date: Tue, 15 Jul 2003 19:22:53 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jamie Lokier <jamie@shareable.org>, Gerd Knorr <kraxel@suse.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch] vesafb fix
Message-ID: <20030715182253.GG15505@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jamie Lokier <jamie@shareable.org>, Gerd Knorr <kraxel@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andi Kleen <ak@suse.de>
References: <20030715141023.GA14133@bytesex.org> <20030715173557.GB1491@mail.jlokier.co.uk> <20030715175358.GB15505@suse.de> <1058292400.3845.59.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058292400.3845.59.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 07:06:41PM +0100, Alan Cox wrote:

 > Not all the MTRR using chips use PAT - but its certainly a start.
Sure.

 > The
 > base algorithm for allocating MTRRs as efficiently as sanely possible
 > is already in the kernel btw - or pretty close to it - its used by
 > the Winchip code to cover RAM with out of order store.

Does that support wierdo cases like Jamie's though?
I can't see how you can cover an not-a-powerof2 size area of memory
without doing too little/too much. The winchip code was written with
RAM in mind, which is always a power of 2 unless you boot with
mem=fooMB

		Dave

