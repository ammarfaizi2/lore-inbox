Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUCGEPR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 23:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbUCGEPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 23:15:17 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:58339 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S261741AbUCGEPN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 23:15:13 -0500
Message-ID: <404AA1B2.4090500@matchmail.com>
Date: Sat, 06 Mar 2004 20:14:42 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Jean-Luc Cooke <jlcooke@certainkey.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       James Morris <jmorris@redhat.com>,
       Christophe Saout <christophe@saout.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: DM for detecting bad disks was: dm-crypt, new IV and standards
References: <20040220172237.GA9918@certainkey.com> <Xine.LNX.4.44.0402201624030.7335-100000@thoron.boston.redhat.com> <20040221164821.GA14723@certainkey.com> <Pine.LNX.4.58.0403022352080.12846@twinlark.arctic.org> <20040303150647.GC1586@certainkey.com> <20040304150836.GE531@openzaurus.ucw.cz>
In-Reply-To: <20040304150836.GE531@openzaurus.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>>Well, CTR mode is not recommended for encrypted file systems because it is very
>>>>easy to corrupt single bits, bytes, blocks, etc without an integrity check.
>>>>If we add a MAC, then any mode of operation except ECB can be used for
>>>>encrypted file systems.
>>>
>>>what does "easy to corrupt" mean?  i haven't really seen disks generate
>>>bit errors ever.  this MAC means you'll need to write integrity data for
>>>every real write.  that really doesn't seem worth it...
>>
>>The difference between "_1,000,000" and "_8,000,000" is 1 bit.  If an
>>attacker knew enough about the layout of the filesystem (modify times on blocks,
>>etc) they could flip a single bit and change your _1Mil purchase order
>>approved by your boss to a _8Mil order.
> 
> 
> Hmm... long time ago I created crc loop device to catch
> faulty disks. If cryptoloop can do that for me... very good!

Yes, a crc, or some other very low overhead DM target would be great for 
this.  I haven't looked at DM too much. :( Does it already have 
something like this already?
