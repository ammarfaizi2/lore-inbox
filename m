Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318996AbSHMUM1>; Tue, 13 Aug 2002 16:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319009AbSHMUM1>; Tue, 13 Aug 2002 16:12:27 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35066 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318996AbSHMUM0>; Tue, 13 Aug 2002 16:12:26 -0400
Subject: Re: [patch] PCI Cleanup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Greg KH <gregkh@us.ibm.com>
In-Reply-To: <2011880000.1029268652@flay>
References: <Pine.LNX.4.44.0208131013060.7411-100000@home.transmeta.com> 
	<2011880000.1029268652@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Aug 2002 21:13:53 +0100
Message-Id: <1029269633.22847.92.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-13 at 20:57, Martin J. Bligh wrote:

> > to do conf2 accesses, and nothing else. So it duplicates its own conf2 
> > functions right now, because it has no way to hook into the generic ones).
> 
> OK, that IDE thing smacks of unmitigated evil to me, but if things are relying 
> on it, we shouldn't change it.

It wants to force its own conf1/conf2 over the BIOS even if BIOS is
preferred because some BIOSes dont honour the size requested and the
hardware has bugs.

That to me says there may well be cleaner approaches.

Alan

