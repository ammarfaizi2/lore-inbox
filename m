Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932613AbWAJUxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbWAJUxq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbWAJUxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:53:45 -0500
Received: from [81.2.110.250] ([81.2.110.250]:16583 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932613AbWAJUxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:53:32 -0500
Subject: Re: 2G memory split
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Jens Axboe <axboe@suse.de>, Byron Stanoszek <gandalf@winds.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <43C3E74D.7060309@wolfmountaingroup.com>
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu>
	 <20060110133728.GB3389@suse.de>
	 <Pine.LNX.4.63.0601100840400.9511@winds.org>
	 <20060110143931.GM3389@suse.de>
	 <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org>
	 <43C3F986.4090209@mbligh.org>
	 <Pine.LNX.4.64.0601101028360.4939@g5.osdl.org>
	 <43C3E74D.7060309@wolfmountaingroup.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Jan 2006 20:55:19 +0000
Message-Id: <1136926519.14532.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-10 at 09:56 -0700, Jeff V. Merkey wrote:
> RH ES uses 4:4 which is ideal and superior to this hack.

Its a non trivial trade-off. 4/4 lets you run very large physical memory
systems much more efficiently than usual but you pay a cost on syscalls
and some other events when using the majority of processors. The 4/4
tricks also give most emulations (eg Qemu) serious heartburn trying to
emulate %cr3 reloading via mmap and other interfaces with high overhead
in relative terms.

Of course AMD64 kind of shot the problem in the head once and for all.

Alan

