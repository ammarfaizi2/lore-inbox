Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVBOXW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVBOXW5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 18:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVBOXWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 18:22:46 -0500
Received: from ext-nj2gw-6.online-age.net ([64.14.56.42]:11907 "EHLO
	ext-nj2gw-6.online-age.net") by vger.kernel.org with ESMTP
	id S261945AbVBOXV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 18:21:28 -0500
Date: Wed, 16 Feb 2005 00:19:28 +0100
From: Kiniger <karl.kiniger@med.ge.com>
To: lsorense@csclub.uwaterloo.ca
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Randy.Dunlap" <rddunlap@osdl.org>,
       sergio@sergiomb.no-ip.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give	dev=/dev/hdX as device
Message-ID: <20050215231928.GB24023@wszip-kinigka.euro.med.ge.com>
References: <1108426832.5015.4.camel@bastov> <1108434128.5491.8.camel@bastov> <42115DA2.6070500@osdl.org> <1108486952.4618.10.camel@localhost.localdomain> <20050215194813.GA20922@wszip-kinigka.euro.med.ge.com> <20050215201514.GC17865@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215201514.GC17865@csclub.uwaterloo.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 03:15:14PM -0500, lsorense@csclub.uwaterloo.ca wrote:
> On Tue, Feb 15, 2005 at 08:48:13PM +0100, Kiniger, Karl (GE Healthcare) wrote:
> > I can confirm that. Creating a correct  iso image from a CD is a
> > major pain w/o ide-scsi. Depending on what one has done before the iso
> > image is missing some data at the end most of the time.
> > (paired with lots of kernel error messages)
> > 
> > Testing was done here using Joerg Schilling's sdd:
> > 
> > sdd ivsize=`isosize /dev/cdxxx` if=/dev/cdxxx of=/dev/null \
> > 	bs=<several block sizes from 2048 up tried,does not matter>
> > 
> > and most of the time it results in bad iso images....
> 
> I have only ever used his readcd program for doing such things.  It has
> been so long I can't even remember if it was using ide-scsi or ide-cd.
> 
> For burning I use ide-cd with cdrecord and growisofs, and so far it has
> worked great.  Flashing firmware on the plextor still requires ide-scsi
> though.

Burning has not been the problem here, just reading. At least
`isosize /dev/cdxxx` bytes have to be readable  and I am always
burning with additional pad sectors at the end and even 32kb
were not always enough to get all files contents......

Karl

> 
> Lennart Sorensen

-- 
Karl Kiniger   mailto:karl.kiniger@med.ge.com
GE Medical Systems Kretztechnik GmbH & Co OHG
Tiefenbach 15       Tel: (++43) 7682-3800-710
A-4871 Zipf Austria Fax: (++43) 7682-3800-47
