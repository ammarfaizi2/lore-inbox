Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266975AbUBGQok (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 11:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266974AbUBGQoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 11:44:37 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:64648 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266973AbUBGQoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 11:44:32 -0500
Message-ID: <40251601.6050304@namesys.com>
Date: Sat, 07 Feb 2004 08:44:49 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: the grugq <grugq@hcunix.net>, Valdis.Kletnieks@vt.edu,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Edward Shishkin <edward@namesys.com>
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <200402040320.i143KCaD005184@turing-police.cc.vt.edu> <20040207002010.GF12503@mail.shareable.org> <40243C24.8080309@namesys.com> <40243F97.3040005@hcunix.net> <40247A63.1030200@namesys.com> <4024B618.2070202@hcunix.net> <20040207104712.GA16093@mail.shareable.org>
In-Reply-To: <20040207104712.GA16093@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Exactly right.

Hans

Jamie Lokier wrote:

>the grugq wrote:
>  
>
>>If, on the other hand, we have a threat model of, say, the police, then 
>>things are very different. In the UK, there is a law which requires you 
>>to turn over your encryption keys when the court demands them. The 
>>police have a tactic for extracting keys which involves physical 
>>violence and intimidation. These are very effective against encryption. 
>>    
>>
>
>This is how to implement secure deletion cryptographically:
>
>   - Each time a file is created, choose a random number.
>
>   - Encrypt the number with your filesystem key and store the
>     encrypted version in the inode.
>
>   - The number is used for encrypting that file.
>
>Secure deletion is then a matter of securely deleting the inode.
>The file data does not have to be overwritten.
>
>This is secure against many attacks that "secure deletion" by
>overwriting is weak against.  This includes electron microscopes
>looking at the data, and UK law.  (The police can demand your
>filesystem key, but nobody knows the random number that belonged to a
>new-deleted inode).
>
>There is a chance the electron microscope may recover the number from
>the securely deleted inode.  That is the weakness of this system,
>therefore the inode data should be very thoroughly erased or itself
>subject to careful cryptographic hding.
>
>-- Jamie
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

