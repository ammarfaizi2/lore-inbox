Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267433AbTAGRCI>; Tue, 7 Jan 2003 12:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbTAGRCI>; Tue, 7 Jan 2003 12:02:08 -0500
Received: from [195.208.223.236] ([195.208.223.236]:6272 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267433AbTAGRBV>; Tue, 7 Jan 2003 12:01:21 -0500
Date: Tue, 7 Jan 2003 20:05:37 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Grant Grundler <grundler@cup.hp.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
Message-ID: <20030107200537.B559@localhost.park.msu.ru>
References: <Pine.LNX.4.44.0301052009050.3087-100000@home.transmeta.com> <1041848998.666.4.camel@zion.wanadoo.fr> <20030106194513.GC26790@cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030106194513.GC26790@cup.hp.com>; from grundler@cup.hp.com on Mon, Jan 06, 2003 at 11:45:13AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 11:45:13AM -0800, Grant Grundler wrote:
> On Mon, Jan 06, 2003 at 11:31:10AM +0100, Benjamin Herrenschmidt wrote:
> > For example, since we do not quite deal with PCI domains yet,
> 
> I thought Bjorn Helgaas submitted "PCI Segment" support for ia64?
> Was something else missing from that? Or was that 2.4.x only?

I guess it was just a catch up with alpha, ppc and sparc. ;-)

> IIRC, lspci needs to be fixed to support this as well.

No, unless we change the API and start exporting the domain
number (pci_controller_num) to userspace. It would be a major pain
as it would break a lot of things, X server in the first place.
In-kernel representation of the PCI domains is a non-issue, really.

Ivan.
