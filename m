Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWHEPLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWHEPLS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 11:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWHEPLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 11:11:18 -0400
Received: from s-utl02-sjpop.stsn.net ([72.254.0.202]:40818 "HELO
	s-utl02-sjpop.stsn.net") by vger.kernel.org with SMTP
	id S1750832AbWHEPLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 11:11:17 -0400
Subject: Re: Zeroing data blocks
From: Arjan van de Ven <arjan@infradead.org>
To: Avinash Ramanath <avinashr@gmail.com>
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <abcd72470608050055w51f2bfbcrbd26b59fc32dc494@mail.gmail.com>
References: <abcd72470607081856i47f15dedre9be9278ffa9bab4@mail.gmail.com>
	 <1152435182.3255.39.camel@laptopd505.fenrus.org>
	 <abcd72470608050055w51f2bfbcrbd26b59fc32dc494@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 05 Aug 2006 17:10:20 +0200
Message-Id: <1154790620.3054.69.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-05 at 00:55 -0700, Avinash Ramanath wrote:
> Hi,
> 
> As per your suggestion, if I write a file with zero bits, it would
> remap to other pages, and I might not zero the real pages. So is there
> any other way that I can access the pages that a file is using?

there is an ioctl to find the blocks the file is in.. but still that's
only a snapshot, not a guarantee. What you really need/want is to do
this at the filesystem level, you can't reliably do it above that level.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com


