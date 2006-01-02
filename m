Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWABX6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWABX6j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 18:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWABX6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 18:58:39 -0500
Received: from [81.2.110.250] ([81.2.110.250]:28594 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751135AbWABX6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 18:58:38 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, Krzysztof Halasa <khc@pm.waw.pl>,
       Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
In-Reply-To: <20060102222335.GB5412@flint.arm.linux.org.uk>
References: <20051230074916.GC25637@elte.hu>
	 <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu>
	 <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu>
	 <1136198902.2936.20.camel@laptopd505.fenrus.org>
	 <20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu>
	 <m3ek3qcvwt.fsf@defiant.localdomain>
	 <1136227893.2936.51.camel@laptopd505.fenrus.org>
	 <20060102222335.GB5412@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Jan 2006 23:55:41 +0000
Message-Id: <1136246141.8570.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-01-02 at 22:23 +0000, Russell King wrote:
> > you know what? gcc inlines those automatic even without you typing
> > "inline". (esp if you have unit-at-a-time enabled)

> GCC will only automatically inline using -O3.  We don't use -O3 with
> the kernel - only -O2 and -Os.

Or using -finline-functions which is a good idea. -O3 has some other
undesirable side effects. Both -O2 -finline-functions and -Os
-finline-functions will do what looks to be the right thing.

Mind you anything more than a few instructions is questionable with
current processors.

Alan

