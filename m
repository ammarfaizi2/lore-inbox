Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265911AbUBGBfX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 20:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266107AbUBGBfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 20:35:23 -0500
Received: from www.trustcorps.com ([213.165.226.2]:19216 "EHLO raq1.nitrex.net")
	by vger.kernel.org with ESMTP id S265911AbUBGBc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 20:32:57 -0500
Message-ID: <40243F97.3040005@hcunix.net>
Date: Sat, 07 Feb 2004 01:29:59 +0000
From: the grugq <grugq@hcunix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Jamie Lokier <jamie@shareable.org>, Valdis.Kletnieks@vt.edu,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <200402040320.i143KCaD005184@turing-police.cc.vt.edu> <20040207002010.GF12503@mail.shareable.org> <40243C24.8080309@namesys.com>
In-Reply-To: <40243C24.8080309@namesys.com>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I think secure deletion should be an option for everyone. Using 
encryption is a data hiding technique, you prevent people for detemining 
what sort of data is being stored there. Now, admittedly I dont know at 
what level the reiser4 encryption appears, but I would think its safer 
to have complete erasure when a file deleted regardless of how well 
protected its contents were.

just a thought.

--gq

Hans Reiser wrote:
> Jamie Lokier wrote:
> 
>> Valdis.Kletnieks@vt.edu wrote:
>>  
>>
>>> Actually, I have encountered file systems where two successive
>>> write() calls from userspace to the same offset in the file wouldn't
>>> end up in the same physical location on the disk (AIX's JFS with 
>>> compression).
>>>   
>>
>>
>> See also:
>>
>>    - ext3 with data journalling
>>
>>    - reiser4 with wandering logs
>>
>>    - experimental ext? patches for tail-packing small files
>>
>> -- Jamie
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>>  
>>
> reiser4 probably does not need secure deletion as much as others, 
> because once the encryption plugins are debugged we will most likely 
> encourage users to use encryption by default.  Perhaps someone will show 
> the error in my thinking though, I am not trying to be rigid here....
> 
