Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVBOULr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVBOULr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVBOUKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:10:14 -0500
Received: from host.atlantavirtual.com ([209.239.35.47]:35302 "EHLO
	host.atlantavirtual.com") by vger.kernel.org with ESMTP
	id S261862AbVBOUGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:06:13 -0500
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and
	give	dev=/dev/hdX as device
From: kernel <kernel@crazytrain.com>
Reply-To: kernel@crazytrain.com
To: "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Randy.Dunlap" <rddunlap@osdl.org>,
       sergio@sergiomb.no-ip.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050215194813.GA20922@wszip-kinigka.euro.med.ge.com>
References: <1108426832.5015.4.camel@bastov>
	 <1108434128.5491.8.camel@bastov> <42115DA2.6070500@osdl.org>
	 <1108486952.4618.10.camel@localhost.localdomain>
	 <20050215194813.GA20922@wszip-kinigka.euro.med.ge.com>
Content-Type: text/plain
Message-Id: <1108497781.3828.51.camel@crazytrain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 15 Feb 2005 15:03:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 14:48, Kiniger, Karl (GE Healthcare) wrote:
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

Karl,

what about catting out that device?  I.E., 

'cat /dev/cdxxx > some.iso'

*instead* of using 'dd' (or variants) against it?  I've always had good
results using 'cat' and CDs, avoiding 'dd' and CDs whenever the
opportunity presents itself.


regards,


-fd




