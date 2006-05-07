Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWEGSnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWEGSnQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 14:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWEGSnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 14:43:16 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:61908
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751231AbWEGSnP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 14:43:15 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 0/6] New Generic HW RNG (#2)
Date: Sun, 7 May 2006 20:50:01 +0200
User-Agent: KMail/1.9.1
References: <20060507143806.465264000@pc1> <200605072039.08702.arnd@arndb.de>
In-Reply-To: <200605072039.08702.arnd@arndb.de>
Cc: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       Sergey Vlasov <vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605072050.01719.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 May 2006 20:39, you wrote:
> On Sunday 07 May 2006 16:38, Michael Buesch wrote:
> > Second try. Various fixes included. This does even compile (and work) now. :)
> > 
> 
> It would be good to give the patches more descriptive names, currently
> they all have the same subject lines, which is not really helpful.

How to do this with quilt?

> > The userspace RNG daemon can later be updated to select the RNG through
> > /sys/class/misc/hw_random/ for convenience. For now it is sufficient to
> > use cat and echo -n on the sysfs attributes.  
> 
> When you're making the behaviour of hw_random configurable, maybe you could
> also add an option to automatically use the current hw_random driver to
> feed the /dev/random entropy pool on systems where the administrator trusts
> its randomness.

This has been discussed and it is not desired behaviour.
If you want to feed /dev/random, use rngd to read from /dev/hwrng,
validate the data and put it into /dev/random.

-- 
Greetings Michael.
