Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286650AbRL1BfW>; Thu, 27 Dec 2001 20:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286649AbRL1BfM>; Thu, 27 Dec 2001 20:35:12 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:17932 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S286650AbRL1Be4>; Thu, 27 Dec 2001 20:34:56 -0500
Message-ID: <3C2BCBC8.20007@namesys.com>
Date: Fri, 28 Dec 2001 04:32:56 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Christian Ohm <chr.ohm@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: file corruption in 2.4.16/17
In-Reply-To: <20011222220223.GA537@moongate.thevoid.net> <3C26F2AC.1050809@namesys.com> <20011225004459.GB3752@moongate.thevoid.net> <3C285384.3020302@namesys.com> <20011226005327.GA3970@moongate.thevoid.net> <20011226092024.A871@namesys.com> <20011227030946.GA472@moongate.thevoid.net> <3C2B00B3.4040505@namesys.com> <20011228002412.GA691@moongate.thevoid.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Ohm wrote:

>On Thu, Dec 27, 2001 at 02:06:27PM +0300, Hans Reiser wrote:
>
>>It sounds like you get reiserfs corruptions easily, without crashing the 
>>machine or anythin unusual, and in that case you surely have hardware 
>>problems.  Please note in our FAQ the discussion of how reiserfs runs 
>>hotter than ext2, and it is common for improperly cooled CPUs to work 
>>well for ext2 and not reiserfs (tail combining heats the CPU).
>>
>
>not likely; its a duron 700 and lm-sensors says < 37 degree celsius with
>open case (as it is now) and about 45 with closed case.
>
>anyway, i've created a new fat32 partition where the old reiserfs one was,
>copied lots of files to it and diffed them. no difference. i copied the same
>files as earlier to the new reiserfs partition and diffed them. no
>difference. no other corrupted files elsewhere, as far as i have seen now.
>so whatever was the cause of this seems to have gone now (always the same
>kernel, nothing changed with the hardware). perhaps the reiserfs file system
>structure got corrupted somehow and thus caused this. don't know. if i have
>nothing else to do, i'll create another reiserfs partition where the old one
>was and try to corrupt some files.
>
>i'll report back if i get corrupted files again. until then, thanks to
>everyone trying to help me and sorry for taking your time.
>
>bye
>christian ohm
>
>
Oh, this is frustrating.  Ok, let me throw out my last lame possible 
diagnosis and suggest that maybe in this case it was not bad CPU but bad 
harddrive, and the drive has now remapped the sector so you can't get 
the corruption again.  Or it could be a corruption due to a software bug 
that continued to affect subsequent writes.  I apologize that we failed 
to give you a good diagnosis on this one.  If I remember right there was 
a corruption causing bug in 2.4.16 that wasn't due to reiserfs but 
affected us (and unfortunately I can't recall at the moment what it was, 
maybe somebody can.)  

My apologies for wasting your time with poor diagnostics.

Hans

