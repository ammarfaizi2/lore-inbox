Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281046AbRKGXBU>; Wed, 7 Nov 2001 18:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281040AbRKGXBL>; Wed, 7 Nov 2001 18:01:11 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:53766 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S281043AbRKGXBE>; Wed, 7 Nov 2001 18:01:04 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
Date: Wed, 7 Nov 2001 23:01:02 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9scefe$hgf$1@ncc1701.cistron.net>
In-Reply-To: <F57jukJ1zkc6g9wHRQa0000b09f@hotmail.com>
X-Trace: ncc1701.cistron.net 1005174062 17935 195.64.65.67 (7 Nov 2001 23:01:02 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <F57jukJ1zkc6g9wHRQa0000b09f@hotmail.com>,
William Knop <w_knop@hotmail.com> wrote:
>
>>Yes, but I meant a program which reads a single binary value and >outputs 
>>it as ascii, as a generic layer between the binary /proc and >the ascii 
>>world of shell scripts.
>>
>>I don't like a binary /proc.
>
>The binary issue could very easily be solved, as you said, by a small 
>generic program to do the conversion. Upside it only shell scripts need 
>this, while more advanced (lower level) programs will get better preformance 
>out of binary format. Downside? I am not sure I see the problem. If a 
>program needs to get a lot of /proc info frequently, a binary interface will 
>be faster. Idealistically, do we want the kernel interfaces binary or ascii? 
>Do we want them to preform best with (be native to) shell scripts or 
>programs?

Both. /proc in ascii for shell scripts etc, and sysctl() in binary
for C programs and the like.

Something like

sysctl(SYSCTL_GET, "fs.file-max", SYSCTL_TYPE_INT, &val, sizeof(val))

It gets you free type checking as well.

Perhaps you even want a opendir()/getdents() type sysctl function
so you can walk the tree without /proc being mounted at all.

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

