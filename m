Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270534AbTGZRAI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 13:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272549AbTGZRAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 13:00:08 -0400
Received: from dsl-hkigw3g81.dial.inet.fi ([80.222.38.129]:41108 "EHLO
	uworld.dyndns.org") by vger.kernel.org with ESMTP id S270534AbTGZRAF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 13:00:05 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: Jussi Laako <jussi.laako@pp.inet.fi>
To: Yury Umanets <umka@namesys.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1059203990.21910.13.camel@haron.namesys.com>
References: <3F1EF7DB.2010805@namesys.com>
	 <1059062380.29238.260.camel@sonja>
	 <16160.4704.102110.352311@laputa.namesys.com>
	 <1059093594.29239.314.camel@sonja>
	 <16161.10863.793737.229170@laputa.namesys.com>
	 <1059142851.6962.18.camel@sonja>
	 <1059143985.19594.3.camel@haron.namesys.com>
	 <1059181687.10059.5.camel@sonja>
	 <1059203990.21910.13.camel@haron.namesys.com>
Content-Type: text/plain
Organization: 
Message-Id: <1059239696.3036.4.camel@vaarlahti.uworld>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Jul 2003 20:14:57 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-26 at 10:19, Yury Umanets wrote:

> > So basically we do have pretty powerful hardware with huge storage and
> > memory and now need a FS which is fast and reliable even on flash
> > memory. JFFS2 is nice but way too slow once one has bigger sizes.
> 
> I think this is more then enough for running reiser4. Reiser4 is a linux
> filesystem first of all, and linux is able to be ran on even worse
> hardware then you have.

Most Linux filesystems can't be used properly with flash devices because
of unability to handle write errors caused by flash wearing out. FS
should mark the block as bad and relocate the data. Some devices report
"read correctly, but had ECC" and when such happens data should also be
relocated to not worn-out place and block marked as bad.


-- 
Jussi Laako <jussi.laako@pp.inet.fi>

