Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVCNNzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVCNNzh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 08:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVCNNzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 08:55:37 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:64459 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261503AbVCNNza
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 08:55:30 -0500
In-Reply-To: <42277ED8.6050500@suse.com>
References: <20050301211824.GC16465@locomotive.unixthugs.org> <1109806334.5611.121.camel@gaston> <42275536.8060507@suse.com> <20050303202319.GA30183@suse.de> <42277ED8.6050500@suse.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Message-Id: <b34edd09a60d945f41bbe123a8321f22@kernel.crashing.org>
Cc: Olaf Hering <olh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] openfirmware: adds sysfs nodes for openfirmware	devices
Date: Sun, 13 Mar 2005 16:17:19 +0100
To: Jeff Mahoney <jeffm@suse.com>
X-Mailer: Apple Mail (2.619.2)
X-MIMETrack: Itemize by SMTP Server on D12ML064/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 14/03/2005 14:55:28,
	Serialize by Router on D12ML064/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 14/03/2005 14:55:29,
	Serialize complete at 14/03/2005 14:55:29
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to follow up this late...

>>> Is whitespace (in any form) allowed in the compatible value?

No.  Only printable characters are allowed, that is, byte values
0x21..0x7e and 0xa1..0xfe; each text string is terminated by a
0x00; there can be several text strings concatenated in one
"compatible" property.

>> Yes, whitespace is used at least in the toplevel compatible file, like
>> 'Power Macintosh' in some Pismo models.

So those OF implementations violate the OF specification.

> Oh well, it was wishful thinking anyway. ;)
>
> I see two potential solutions:
> * Ideally, I'd like to find a character (pipe?) that isn't used in the
>   Apple OF compatible property. I've been unable to find any
>   documentation that specifies to this level of detail. (Well, without
>   paying for the IEEE-1275 reference, and it may not even be there.)

See 2.3.75 and 3.2.2.1.2 in the OF spec.


Segher

