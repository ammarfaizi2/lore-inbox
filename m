Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTLPQsG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 11:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTLPQsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 11:48:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:60120 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261898AbTLPQsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 11:48:02 -0500
Date: Tue, 16 Dec 2003 08:47:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
cc: arjanv@redhat.com, Gabriel Paubert <paubert@iram.es>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Martin Mares <mj@ucw.cz>, zaitcev@redhat.com, hch@infradead.org
Subject: Re: PCI Express support for 2.4 kernel
In-Reply-To: <3FDEDC77.9010203@intel.com>
Message-ID: <Pine.LNX.4.58.0312160844110.1599@home.osdl.org>
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com> 
 <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>  <3FDDACA9.1050600@intel.com>
 <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com>
 <Pine.LNX.4.58.0312151154480.1631@home.osdl.org> <3FDEDC77.9010203@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Dec 2003, Vladimir Kondratiev wrote:
>
> I re-worked the patch. This time it uses fixmap; I added config
> parameters to disable this code and to handle non-default base address.

Ok, this looks sane to me.

However, I have a totally independent question: do new PCI Express host
bridges really not just suppor the old PCI config access interface?

Quite frankly, if I was a manager in charge of a PCI Express host bridge,
and it didn't support the old C8C IO access patterns, I'd be so ashamed of
myself that I'd kill my whole development team with rat poison, and then
blame them for the mistake(*).

Do we know of any sudden suspicious death waves inside certain groups at
Intel?

		Linus

(*) That's how managers work, after all. Long gone are the days when
personal shame caused you to take personal responsibility.
