Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313989AbSDKFh4>; Thu, 11 Apr 2002 01:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313990AbSDKFhz>; Thu, 11 Apr 2002 01:37:55 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:51865 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S313989AbSDKFhy>; Thu, 11 Apr 2002 01:37:54 -0400
Date: Wed, 10 Apr 2002 22:38:06 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Kevin Hilman <kevin@hilman.org>, linux-kernel@vger.kernel.org
Subject: Re: ioremap() >= 128Mb (was: Memory problem with bttv driver)
Message-ID: <2119843704.1018478285@[10.10.2.3]>
In-Reply-To: <87sn63tbzq.fsf@bugs.hilman.org>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The basic problem is that I have a machine with 1G physical memory and
> a device with an 128Mb of on-board memory that I would like to
> ioremap().  Of course, since VMALLOC_RESERVE is 128Mb this will always
> fail if there have been any previous calls to vmalloc() or ioremap()

Or even if there have been no previous calls, since other things
(fixmap, kmap, etc) come out of that space too. 

M.

