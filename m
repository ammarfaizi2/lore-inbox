Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUFKKn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUFKKn5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 06:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbUFKKn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 06:43:57 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:47546 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S263795AbUFKKn4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 06:43:56 -0400
References: <200406082124.i58LOuOL016163@melkki.cs.helsinki.fi>
            <20040609113455.U22989@build.pdx.osdl.net>
            <1086812001.13026.63.camel@cherry>
            <1086812486.2810.21.camel@laptop.fenrus.com>
            <1086814663.13026.70.camel@cherry>
            <20040609205944.GA21150@devserv.devel.redhat.com>
            <1086815269.13026.76.camel@cherry>
            <s5hu0xiz9qz.wl@alsa2.suse.de>
In-Reply-To: <s5hu0xiz9qz.wl@alsa2.suse.de>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Takashi Iwai <tiwai@suse.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: ALSA: Remove subsystem-specific malloc (1/8)
Date: Fri, 11 Jun 2004 13:43:55 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.40C98CEB.00002821@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

On 6/11/2004, "Takashi Iwai" <tiwai@suse.de> wrote:
> I don't think the shortcut is necessary, too.
> By calling kmalloc with 0, the same behavior as kmalloc is
> guaranteed.

Agreed. I'm wondering if the overflow case should set size to zero and call 
kmalloc() as well. 

		Pekka 

