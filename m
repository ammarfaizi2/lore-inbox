Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267568AbTAGSLT>; Tue, 7 Jan 2003 13:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267569AbTAGSLT>; Tue, 7 Jan 2003 13:11:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50190 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267568AbTAGSLS>; Tue, 7 Jan 2003 13:11:18 -0500
Date: Tue, 7 Jan 2003 09:46:52 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Grant Grundler <grundler@cup.hp.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, <davidm@hpl.hp.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
In-Reply-To: <20030107200537.B559@localhost.park.msu.ru>
Message-ID: <Pine.LNX.4.44.0301070945300.1913-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Jan 2003, Ivan Kokshaysky wrote:
> 
> > IIRC, lspci needs to be fixed to support this as well.
> 
> No, unless we change the API and start exporting the domain
> number (pci_controller_num) to userspace.

It _is_ already exported. /sys gets this right, as far as I know (I don't
have any machines to test with, but at least it's not anything
fundamentally hard to fix in case there's something missing).

But yes, X and lspci would need to know about /sys.

		Linus

