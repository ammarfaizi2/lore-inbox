Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268016AbTAIWfU>; Thu, 9 Jan 2003 17:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268017AbTAIWfU>; Thu, 9 Jan 2003 17:35:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55304 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268016AbTAIWfO>; Thu, 9 Jan 2003 17:35:14 -0500
Date: Thu, 9 Jan 2003 14:16:20 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Grant Grundler <grundler@cup.hp.com>, Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, <davidm@hpl.hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <greg@kroah.com>
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
In-Reply-To: <20030110010917.A693@localhost.park.msu.ru>
Message-ID: <Pine.LNX.4.44.0301091413520.1436-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Jan 2003, Ivan Kokshaysky wrote:
>
> Note that in most cases PCI-PCI bridges can be safely excluded from
> pci_read_bases() simply because they have neither regular BARs nor
> ROM BAR (even though PCI spec allows that).

This might be a good approach to take regardless - don't read pci-pci 
bridge BAR (or host-bridge BAR's for that matter), simply because 

 (a) bridges are more "interesting" than regular devices, and disabling 
     part of them might be a stupid thing.
 (b) we're generally not really interested in the end result anyway

Hmm?

		Linus

