Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265456AbTFZIKi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 04:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265458AbTFZIKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 04:10:38 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:51725 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265456AbTFZIKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 04:10:37 -0400
Date: Thu, 26 Jun 2003 09:24:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Hunold <hunold@convergence.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Marcus Metzler <mocm@metzlerbros.de>, Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Johannes Stezenbach <js@convergence.de>
Subject: Re: DVB Include files
Message-ID: <20030626092444.A26890@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Hunold <hunold@convergence.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Marcus Metzler <mocm@metzlerbros.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Johannes Stezenbach <js@convergence.de>
References: <16121.56382.444838.485646@sheridan.metzler> <20030625185036.C29537@infradead.org> <16121.58735.59911.813354@sheridan.metzler> <20030625191532.A1083@infradead.org> <16121.60747.537424.961385@sheridan.metzler> <20030625194250.GF1770@wohnheim.fh-wedel.de> <16122.379.321217.737557@sheridan.metzler> <20030625202312.GG1770@wohnheim.fh-wedel.de> <1056582481.1998.20.camel@dhcp22.swansea.linux.org.uk> <3EFAAC69.6090709@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EFAAC69.6090709@convergence.de>; from hunold@convergence.de on Thu, Jun 26, 2003 at 10:18:49AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 26, 2003 at 10:18:49AM +0200, Michael Hunold wrote:
> In include/linux/dvb we have the headers that are shared between user
> applications and the kernel driver. As I said above, these are stable and
> never change for the v3 api. In an ideal world, these header files would
> be included in your glibc distribution at /usr/include/linux/dvb
> Currently, you must copy them by hand or create a symlink, because there
> hasn't been an official kernel with the dvb driver subsystem yet.

And that's the whole point.  In fact I hear exactly that problem from a
friend at SuSE who maintained an (inofficial?) dvb package.  He packaged
the kernel driver but of course it's not part of the official SuSE kernel
and even more so the kernel headers package that is created with the
kernel package but doesn't change during the lifetime of the glibc
package.  Now he's not allowed to just write into /usr/include/linux/
either because that directory is owned by the kernel headers package.

Please just get over it and put a copy of the headers into /usr/include/dvb,
this makes life easier for everyone.

