Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbUBDRD3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 12:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbUBDRD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 12:03:29 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:53684
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S263606AbUBDRD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 12:03:28 -0500
Message-ID: <40212643.4000104@tmr.com>
Date: Wed, 04 Feb 2004 12:05:07 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: the grugq <grugq@hcunix.net>
CC: "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <20040204004318.GA253@elf.ucw.cz> <20040204062936.GA2663@thunk.org> <4020EEB0.50002@hcunix.net>
In-Reply-To: <4020EEB0.50002@hcunix.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the grugq wrote:
> 
>>
>> The obvious thing to do would be to make it a mount option, so that
>> (a) recompilation is not necessary in order to use the feature, and
>> (b) the feature can be turned on or off on a per-filesystem feature.
>> In 2.6, it's possible to specify certain mount option to be specifed
>> by default on a per-filesystem basis (via a new field in the
>> superblock). 
>> So if you do things that way, then secure deletion would take place
>> either if the secure deletion flag is set (so it can be enabled on a
>> per-file basis), or if the filesystem is mounted with the
>> secure-deletion mount option.  
> 
> 
> Makes sense to me. If either the file system, or the file, are in 
> 'secure delete' mode, then erase everything about the file. Allowing the 
> paranoid to have the option as default, and the concerned to target 
> specific files. I like it.

It would be useful to have this as a directory option, so that all files 
in directory would be protected. I think wherever you do it you have to 
prevent hard links, so that unlink really removes the data.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
