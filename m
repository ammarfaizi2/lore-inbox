Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTLPExy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 23:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbTLPExy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 23:53:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18397 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264358AbTLPExx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 23:53:53 -0500
Message-ID: <3FDE8FD2.2070801@pobox.com>
Date: Mon, 15 Dec 2003 23:53:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDC9DC5.2070302@intel.com> <Pine.LNX.4.58.0312151023570.1488@home.osdl.org> <3FDE1391.7030306@pobox.com> <Pine.LNX.4.58.0312151359300.1631@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312151359300.1631@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Mon, 15 Dec 2003, Jeff Garzik wrote:
>>neat.  dumb question though...  how portable is set_fixmap_nocache()?

> Not very. Although it should generally be trivial to port if you need it.
[...]
> On 64-bit architectures you're not likely to ever need to worry about it,
> and then you can just map the whole thing directly (and use some special
> large-page mapping for it, at that).

Yeah, good point.  IA64 with its 1001 different types of mappings and 
zones can go crazy, for example.

Sounds like PCI express needs a per-architecture policy for mapping the 
256MB region.  Some [64b] arches can direct-map the entire area.  IA32 
and others can go another route.

	Jeff



