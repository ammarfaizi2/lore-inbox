Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTLVEac (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 23:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTLVEac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 23:30:32 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:60295 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262315AbTLVEab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 23:30:31 -0500
Message-ID: <3FE67362.2070704@labs.fujitsu.com>
Date: Mon, 22 Dec 2003 13:30:26 +0900
From: Tsuchiya Yoshihiro <tsuchiya@labs.fujitsu.com>
Reply-To: tsuchiya@labs.fujitsu.com
Organization: Fujitsu Labs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: filesystem bug?
References: <3FDD7DFD.7020306@labs.fujitsu.com>	 <1071582242.5462.1.camel@sisko.scot.redhat.com> <3FDF7BE0.205@jpl.nasa.gov>	 <3FDF95EB.2080903@labs.fujitsu.com>  <3FE0E5C6.5040008@labs.fujitsu.com> <1071782986.3666.323.camel@sisko.scot.redhat.com> <3FE62999.90309@labs.fujitsu.com>
In-Reply-To: <3FE62999.90309@labs.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tsuchiya Yoshihiro wrote:

>>It could possibly be a core VFS bug, but the VFS is in general pretty
>>reliable under load.  We've had problems under specific edge conditions
>>such as races between sync and unmount, but the basic VFS behaviour
>>under load generally gets _lots_ of testing, so I'd definitely start by
>>looking elsewhere.  
>>
>>I'd also like to see how your 2.4.23 and 2.6.0-test11 testing is going. 
>>That might give some clues, too.  There's a race between clear_inode()
>>and read_inode() fixed in those kernels, but that doesn't look relevant
>>here; there may be something else changed that's significant, though.
>>
>> 
>>
>>    
>>
>EXT3 on 2.4.23 and 2.6.0-test11 both failed. I feel when I make the
>filesystem
>smaller - make the filesystem usage 70% to 80% during the test- ,
>the problem happens easyer.
>
>  
>

I tried it with IDE disk and it failed also. It was run on
ext2 on 2.4.23. So it's not a SCSI problem.


Thanks,
Yoshi

--
Yoshihiro Tsuchiya



