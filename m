Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVBOU3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVBOU3p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVBOU3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:29:45 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:14810 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261868AbVBOUPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:15:15 -0500
Date: Tue, 15 Feb 2005 15:15:14 -0500
To: "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Randy.Dunlap" <rddunlap@osdl.org>,
       sergio@sergiomb.no-ip.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give	dev=/dev/hdX as device
Message-ID: <20050215201514.GC17865@csclub.uwaterloo.ca>
References: <1108426832.5015.4.camel@bastov> <1108434128.5491.8.camel@bastov> <42115DA2.6070500@osdl.org> <1108486952.4618.10.camel@localhost.localdomain> <20050215194813.GA20922@wszip-kinigka.euro.med.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215194813.GA20922@wszip-kinigka.euro.med.ge.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 08:48:13PM +0100, Kiniger, Karl (GE Healthcare) wrote:
> I can confirm that. Creating a correct  iso image from a CD is a
> major pain w/o ide-scsi. Depending on what one has done before the iso
> image is missing some data at the end most of the time.
> (paired with lots of kernel error messages)
> 
> Testing was done here using Joerg Schilling's sdd:
> 
> sdd ivsize=`isosize /dev/cdxxx` if=/dev/cdxxx of=/dev/null \
> 	bs=<several block sizes from 2048 up tried,does not matter>
> 
> and most of the time it results in bad iso images....

I have only ever used his readcd program for doing such things.  It has
been so long I can't even remember if it was using ide-scsi or ide-cd.

For burning I use ide-cd with cdrecord and growisofs, and so far it has
worked great.  Flashing firmware on the plextor still requires ide-scsi
though.

Lennart Sorensen
