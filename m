Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbSL1Te0>; Sat, 28 Dec 2002 14:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266307AbSL1Te0>; Sat, 28 Dec 2002 14:34:26 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:49220 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266298AbSL1TeX>; Sat, 28 Dec 2002 14:34:23 -0500
Date: Sat, 28 Dec 2002 14:42:14 -0500
From: Doug Ledford <dledford@redhat.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Tomas Szepe <szepe@pinerecords.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Samuel Flory <sflory@rackable.com>, Janet Morgan <janetmor@us.ibm.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <20021228144214.H29061@redhat.com>
Mail-Followup-To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Tomas Szepe <szepe@pinerecords.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Samuel Flory <sflory@rackable.com>,
	Janet Morgan <janetmor@us.ibm.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com> <176730000.1040430221@aslan.btc.adaptec.com> <3E03BB0D.5070605@rackable.com> <Pine.LNX.4.50L.0212280331110.30646-100000@freak.distro.conectiva> <20021228091608.GA13814@louise.pinerecords.com> <Pine.LNX.4.50L.0212281131580.26879-100000@imladris.surriel.com> <705128112.1041102818@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <705128112.1041102818@aslan.scsiguy.com>; from gibbs@scsiguy.com on Sat, Dec 28, 2002 at 12:13:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 12:13:38PM -0700, Justin T. Gibbs wrote:
> 
> Unfortunately, the versions of the aic7xxx driver that are in the main
> trees (both nearly a year out of date) don't have this test and, like the
> "old" driver, they default to memory mapped I/O.  One of the reasons I've
> been pushing so hard for this new driver to go into the tree is that 90%
> of the complaints about the new driver would go away if it were updated
> to a sane revision.

Actually, no, you need to check 2.5.53 Justin.  Your latest stuff (6.2.24 
or thereabouts I think) has been sucked in and several of the "It breaks 
in 2.5.53" reports that have floated through linux-scsi in the last week 
are in fact about that specific version of the driver.  From the Changelog 
of 2.5.53:

<gibbs@overdrive.btc.adaptec.com>
	Update to aic7xxx 6.2.22 and aic79xx 1.3.0_ALPHA2

<gibbs@overdrive.btc.adaptec.com>
	Remove generated file.

<gibbs@overdrive.btc.adaptec.com>
	Enable highmem_io.

<gibbs@overdrive.btc.adaptec.com>
	o Kill host template files.
	o Move readme files into the Documentation SCSI directory
	o Enable highmem_io
	o Split out Kconfig files for aic7xxx and aic79xx
	
	Host template and large disk changes provided or inspired by:
		Christoph Hellwig <hch@sgi.com>

<gibbs@overdrive.btc.adaptec.com>
	Complete the upgrade to aic7xxx 6.2.23 and aic79xx 1.3.0_ALPHA3.

<gibbs@overdrive.btc.adaptec.com>
	Update to aic7xxx version 6.2.24 and aic79xx version 1.3.0_ALPHA5.

So, in short, your going to have to change your autoresponse to 2.5 
kernels now because Linus bit the bullet and grabbed your tree.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
