Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268113AbTAJC4t>; Thu, 9 Jan 2003 21:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268116AbTAJC4t>; Thu, 9 Jan 2003 21:56:49 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:56463
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268113AbTAJC4s>; Thu, 9 Jan 2003 21:56:48 -0500
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Grant Grundler <grundler@cup.hp.com>, Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
In-Reply-To: <1042151210.523.34.camel@zion.wanadoo.fr>
References: <Pine.LNX.4.44.0301091413520.1436-100000@penguin.transmeta.com>
	 <1042151210.523.34.camel@zion.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042170545.28469.41.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 03:49:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 22:26, Benjamin Herrenschmidt wrote:
> I completely agree. For example, I have already a bunch of cases where I
> have to explicitely "hide" the host bridge from linux PCI layer as those
> have BARs that mustn't be touched. A typical example is the 405gp
> internal PCI host. It has a BAR that represents the view of system RAM
> from bus mastering PCI devices. Of course, the kernel doesn't understand
> that and tries to remap it away from 0 where it belongs ;)

Ditto The X-box people would like to explicitly hide a pile of apparently ghost
devices that hang the bus solid if you read them.
