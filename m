Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266855AbUBGJ6M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 04:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266871AbUBGJ6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 04:58:11 -0500
Received: from www.trustcorps.com ([213.165.226.2]:58628 "EHLO raq1.nitrex.net")
	by vger.kernel.org with ESMTP id S266855AbUBGJ6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 04:58:07 -0500
Message-ID: <4024B618.2070202@hcunix.net>
Date: Sat, 07 Feb 2004 09:55:36 +0000
From: the grugq <grugq@hcunix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Jamie Lokier <jamie@shareable.org>, Valdis.Kletnieks@vt.edu,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <200402040320.i143KCaD005184@turing-police.cc.vt.edu> <20040207002010.GF12503@mail.shareable.org> <40243C24.8080309@namesys.com> <40243F97.3040005@hcunix.net> <40247A63.1030200@namesys.com>
In-Reply-To: <40247A63.1030200@namesys.com>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, but to a large extent it depends on your threat model. If you say 
"an extremely well funded government entity wants to examine your hard 
drive" then they will have access to insane technologies like electron 
microscopes. This makes any software solution to secure deletion 
practically impossible (if we trust the literature).

If, on the other hand, we have a threat model of, say, the police, then 
things are very different. In the UK, there is a law which requires you 
to turn over your encryption keys when the court demands them. The 
police have a tactic for extracting keys which involves physical 
violence and intimidation. These are very effective against encryption. 
However, the police do not have access to hardware based analysis 
technologies, they are just too expensive. So, while they can recover 
something that has been encrypted, they can't recover something that has 
been securely deleted. (Not without begging the .gov to perform a 
hardware analysis, something which would be quite unlikely in the normal 
course of events).

The majority of forensic analysis is performed with software tools on a 
bit image of the hard drive. If this bit image doesn't contain the data, 
the software tools won't see it, and the forensic analysis will fail. I 
would suggest adding secure deletion, because it does provide a pretty 
good level of protection. It is not a 100% solution, but neither is 
encryption. The two in combination are complementary technologies.


peace,

--gq


Hans Reiser wrote:
> There is an extensive literature on how you can recover deleted files 
> from media that has been erased a dozen times, but breaking encryption 
> is harder.  It is more secure to not put the data on disk unencrypted at 
> all is my point.....
> 
> Hans
> 
> the grugq wrote:
> 
>> Well, I think secure deletion should be an option for everyone. Using 
>> encryption is a data hiding technique, you prevent people for 
>> detemining what sort of data is being stored there. Now, admittedly I 
>> dont know at what level the reiser4 encryption appears, but I would 
>> think its safer to have complete erasure when a file deleted 
>> regardless of how well protected its contents were.
>>
>> just a thought.
>>
> 
> 
