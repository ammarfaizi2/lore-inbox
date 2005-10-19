Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVJSQyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVJSQyZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 12:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVJSQyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 12:54:24 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:30220 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751143AbVJSQyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 12:54:23 -0400
Date: Wed, 19 Oct 2005 17:54:20 +0100 (BST)
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Steve Youngs <steve@youngs.au.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13.4 After increasing RAM, I'm getting Bad page state at
 prep_new_page
In-Reply-To: <microsoft-free.877jc9jzwy.fsf@youngs.au.com>
Message-ID: <Pine.LNX.4.63.0510191730570.23833@deepthought.mydomain>
References: <microsoft-free.877jc9jzwy.fsf@youngs.au.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-536394258-1129740860=:23833"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-536394258-1129740860=:23833
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 20 Oct 2005, Steve Youngs wrote:

>
> It's not restricted to any one process, I've seen it in a number of
> different processes: Mozilla, sendmail, postmaster (pgsql).  Of
> course, the first thing I thought of was that I'd been sold some dodgy
> RAM.  But I've run memtest86 (version 3.2) over the RAM and no errors
> were found.
>

  Steve,

  this is almost certainly a hardware problem.  I'm not saying that the 
RAM is actually defective, it could be that the motherboard doesn't 
reliably support that much memory, or even a weak powersupply.

  I prefer to use memtest86+ for recent hardware, but I'm sure 
memtest86 can find errors if you give it long enough (on a 1.8GHz 
athlon64 with a mere 2GB of memory, several hours were needed - the 
memory was good, but the mobo couldn't drive that much at full speed). 
I think some of the tests in memtest86 are marked as 'optional', you 
really want to run all of the tests if in doubt, and probably overnight.

  3GB sounds an awful lot for an athlon - 2x1GB and 2x512MB, I suppose. 
I would not be surprised to hear that a consumer-grade mobo has 
difficulties.  Bitter experience has taught me that it isn't a good idea 
to fill a mobo with more memory than was reasonably envisaged when it 
was designed - sure, the manual probably says it can take it, but linux 
works it hard.  Remember that the windows world thought 1GB was a lot of 
memory until recently.

  Of course, if it's a PSU problem related to excessive power to memory + 
disk(s) + graphics card, memtest86 is unlikely to trigger it.

Ken
-- 
  das eine Mal als Tragödie, das andere Mal als Farce

---1463809536-536394258-1129740860=:23833--
