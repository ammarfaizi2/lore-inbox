Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbTI2TrR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 15:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264636AbTI2TrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 15:47:16 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:20190 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S264155AbTI2TrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 15:47:15 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: Chris Wright <chrisw@osdl.org>
Subject: Re: 2.6.0-test6-mm1: too many defunct event threads
Date: Mon, 29 Sep 2003 21:47:12 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200309292115.57918.gallir@uib.es> <20030929122709.B6895@osdlab.pdx.osdl.net>
In-Reply-To: <20030929122709.B6895@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309292147.12595.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 September 2003 21:27, Chris Wright shaped the electrons to 
shout:
> * Ricardo Galli (gallir@uib.es) wrote:
> > Just tested -mm1 in my laptop, with synaptics drivers, and saw lots
> > of zombi event threads.
>
> Please revert the call_usermodehelper patch.
>
> ftp:/ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test
>6/2.6.0-test6-mm1/broken-out/call_usermodehelper-retval-fix-2.patch

Sorry, a late comer, as always: http://lkml.org/lkml/2003/9/29/152

Seen it. Tested it. Solved it.

Thanks.

BTW, we cannot find the reason for the synaptics timeouts:

Synaptics driver lost sync at 4th byte
Synaptics driver lost sync at 1st byte
Synaptics driver resynced.
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver resynced.

which are the only glitches I find to it.


-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/

