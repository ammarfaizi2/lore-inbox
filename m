Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWAQSdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWAQSdx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWAQSdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:33:53 -0500
Received: from [81.2.110.250] ([81.2.110.250]:19333 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932200AbWAQSdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:33:51 -0500
Subject: Re: Kernel 2.6.15.1 + NFS is 4 times slower than FTP!?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org,
       apiszcz@lucidpixels.com
In-Reply-To: <Pine.LNX.4.64.0601171324010.25508@p34>
References: <Pine.LNX.4.64.0601161957300.16829@p34>
	 <20060117012319.GA22161@linuxace.com>
	 <Pine.LNX.4.64.0601162031220.2501@p34>
	 <Pine.BSO.4.63.0601171846570.15077@rudy.mif.pg.gda.pl>
	 <1137521483.14135.59.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0601171324010.25508@p34>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Jan 2006 18:33:18 +0000
Message-Id: <1137522798.14135.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-17 at 13:24 -0500, Justin Piszcz wrote:
> Alan, is it normal for FTP to be 2x as fast as NFS?
> With 100mbps, I never seemed to have any issues, but with GIGABIT I 
> definitely see all sorts of weird issues.

NFS performance is limited by the fact it is a file system so sees only
what the file system can tell it. It also takes a hit because it has
strict rules on committing data to disk before acknowledging it (so data
is not lost over a crash). That makes NFS a bigger user of CPU resources
and more disk dependant than FTP which simply throws the entire file
down the pipe when in binary mode, does no processing and makes no
guarantee about restarts or what hits disk


