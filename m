Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269368AbTCDK6D>; Tue, 4 Mar 2003 05:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269369AbTCDK6D>; Tue, 4 Mar 2003 05:58:03 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:24785 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S269368AbTCDK6C>; Tue, 4 Mar 2003 05:58:02 -0500
Message-ID: <3E6488FA.2050105@bogonomicon.net>
Date: Tue, 04 Mar 2003 05:07:38 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Vlad Harchev <hvv@hippo.ru>
CC: J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 and cryptofs on raid1 - what will be cached and how many
 times
References: <20030302105634.GA4258@h> <20030303093832.GA4601@h> <15971.52790.676134.722437@notabene.cse.unsw.edu.au> <20030304093020.GA4024@h> <20030304092031.GB6583@wohnheim.fh-wedel.de> <20030304113106.GC4024@h>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Vlad Harchev wrote:

>>A potential attacker can use this to look for the ext2 superblock,
>>which gives him the same data both encrypted an unencrypted. A real
> 
>  
>  I've got an impression that in case of loopback with encryption the 
> superblock will also be encrypted. 
>  If one forgets known cleartext attacks, one can place the filesystem at
> some offset.

Yes it would be encrypted.  Unfortunately it is predictable data and as 
such it is much easier to crack.  Better set that offset at a location 
computed from the encryption key.

On a side note I find it interesting that many people sugest compressing 
a file before encrypting it.  Take a look at the first few bytes of 
every compressed file.  Unless your going to get rid of that header...

>>cryptofs would go through great pains to take such advantages away.

- Bryan




