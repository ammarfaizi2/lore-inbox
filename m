Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVBOXRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVBOXRb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 18:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVBOXRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 18:17:31 -0500
Received: from ext-nj2gw-6.online-age.net ([64.14.56.42]:45036 "EHLO
	ext-nj2gw-6.online-age.net") by vger.kernel.org with ESMTP
	id S261921AbVBOXRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 18:17:17 -0500
Date: Wed, 16 Feb 2005 00:16:24 +0100
From: Kiniger <karl.kiniger@med.ge.com>
To: kernel <kernel@crazytrain.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Randy.Dunlap" <rddunlap@osdl.org>,
       sergio@sergiomb.no-ip.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give	dev=/dev/hdX as device
Message-ID: <20050215231624.GA24023@wszip-kinigka.euro.med.ge.com>
References: <1108426832.5015.4.camel@bastov> <1108434128.5491.8.camel@bastov> <42115DA2.6070500@osdl.org> <1108486952.4618.10.camel@localhost.localdomain> <20050215194813.GA20922@wszip-kinigka.euro.med.ge.com> <1108497781.3828.51.camel@crazytrain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108497781.3828.51.camel@crazytrain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 03:03:02PM -0500, kernel wrote:
> On Tue, 2005-02-15 at 14:48, Kiniger, Karl (GE Healthcare) wrote:
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
> Karl,
> 
> what about catting out that device?  I.E., 
> 
> 'cat /dev/cdxxx > some.iso'
> 
> *instead* of using 'dd' (or variants) against it?  I've always had good
> results using 'cat' and CDs, avoiding 'dd' and CDs whenever the
> opportunity presents itself.

I dont think this is relevant. cat will probably use stdio which will
do blocking similar to dd (perhaps 4 kB).

Interestingly reading the files off the mounted CD works fine.

Karl

> 
> regards,
> 
> 
> -fd
> 
> 

-- 
Karl Kiniger   mailto:karl.kiniger@med.ge.com
GE Medical Systems Kretztechnik GmbH & Co OHG
Tiefenbach 15       Tel: (++43) 7682-3800-710
A-4871 Zipf Austria Fax: (++43) 7682-3800-47
