Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318028AbSHLOHS>; Mon, 12 Aug 2002 10:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318033AbSHLOHS>; Mon, 12 Aug 2002 10:07:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35853 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318028AbSHLOHR>;
	Mon, 12 Aug 2002 10:07:17 -0400
Message-ID: <3D57C1F4.1040303@mandrakesoft.com>
Date: Mon, 12 Aug 2002 10:11:00 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
References: <200208120018.g7C0IFN185157@saturn.cs.uml.edu>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan wrote:
> Jeff Garzik writes:
>>I sure would like an O_STREAMING flag, though...  let a user app hint to 
>>the system that the pages it is reading or writing are perhaps less 
>>likely to be reused, or access randomly....  A copy-file syscall would 
>>be nice, too, but that's just laziness talking....
> 
> 
> You have a laptop computer with a USB-connected Ethernet.
> You mount a NetApp or similar box via the SMB/CIFS protocol.
> You see a multi-gigabyte file. You make a copy... ouch!!!
> For each gigabyte, you hog the network for an hour.

> Now let's say this file is for a MacOS app. You have to
> preserve the creator, file type, resource fork, etc.

/bin/cp has these problems regardless of whether or not it uses a 
copy-file syscall.

	Jeff



