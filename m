Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161178AbWAHKoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161178AbWAHKoP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 05:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161180AbWAHKoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 05:44:15 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:58320 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161178AbWAHKoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 05:44:14 -0500
Date: Sun, 8 Jan 2006 11:43:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>,
       PPC64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: PowerPC fastpaths for mutex subsystem
Message-ID: <20060108104357.GB31359@elte.hu>
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com> <20060105143502.GA16816@elte.hu> <43BD4C66.60001@austin.ibm.com> <20060105222106.GA26474@elte.hu> <43BDA672.4090704@austin.ibm.com> <20060106002919.GA29190@pb15.lixom.net> <43BFFF1D.7030007@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BFFF1D.7030007@austin.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


looks good to me. Minor nit:

> +"	isync\n"

> +"	isync		\n"

shouldnt these two be ISYNC_ON_SMP?

	Ingo
