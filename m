Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267974AbTB1PcE>; Fri, 28 Feb 2003 10:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267975AbTB1PcD>; Fri, 28 Feb 2003 10:32:03 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10386
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267974AbTB1PcD>; Fri, 28 Feb 2003 10:32:03 -0500
Subject: Re: Proposal: Eliminate GFP_DMA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andi Kleen <ak@suse.de>,
       Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <10490000.1046446480@[10.10.2.4]>
References: <20030228064631.G23865@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
	 <p73heao7ph2.fsf@amdsimf.suse.de>
	 <20030228141234.H23865@parcelfarce.linux.theplanet.co.uk>
	 <1046445897.16599.60.camel@irongate.swansea.linux.org.uk>
	 <20030228143405.I23865@parcelfarce.linux.theplanet.co.uk>
	 <1046447737.16599.83.camel@irongate.swansea.linux.org.uk>
	 <20030228145614.GA27798@wotan.suse.de> <20030228152502.GA32449@gtf.org>
	 <10490000.1046446480@[10.10.2.4]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046450702.16599.131.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Feb 2003 16:45:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-28 at 15:34, Martin J. Bligh wrote:
> If we're going to really sort this out, would be nice to just pass an upper
> bound for an address to __alloc_pages, instead of a simple bitmask ;-)

Not all systems work out that way. Some ARM for example have a memory window rather
than a range. It does solve most platforms so its definitely the right basic feature
to have and let awkward boxes overload it.

