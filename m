Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWAQSMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWAQSMP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWAQSMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:12:15 -0500
Received: from [81.2.110.250] ([81.2.110.250]:31140 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932302AbWAQSMM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:12:12 -0500
Subject: Re: Kernel 2.6.15.1 + NFS is 4 times slower than FTP!?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, Phil Oester <kernel@linuxace.com>,
       linux-kernel@vger.kernel.org, apiszcz@lucidpixels.com
In-Reply-To: <Pine.BSO.4.63.0601171846570.15077@rudy.mif.pg.gda.pl>
References: <Pine.LNX.4.64.0601161957300.16829@p34>
	 <20060117012319.GA22161@linuxace.com>
	 <Pine.LNX.4.64.0601162031220.2501@p34>
	 <Pine.BSO.4.63.0601171846570.15077@rudy.mif.pg.gda.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Tue, 17 Jan 2006 18:11:23 +0000
Message-Id: <1137521483.14135.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-17 at 18:48 +0100, Tomasz Kłoczko wrote:
> > I wonder how much faster NFS over TCP would be, or if NFS in the kernel is 
> > the problem itself?
> 
> On Linux NFS over TCP is slower than over UDP ~10%.

For the specific case you measured. Its never quite that simple because
behaviour over different networks and error patterns varies a lot and
TCP can be a big win on loaded networks or under error conditions,
especially packet loss, where fragmentation losses kill throughput on
UDP.


