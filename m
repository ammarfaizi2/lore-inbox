Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292466AbSBZRtV>; Tue, 26 Feb 2002 12:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292476AbSBZRtO>; Tue, 26 Feb 2002 12:49:14 -0500
Received: from loisexc2.loislaw.com ([12.5.234.240]:16900 "EHLO
	loisexc2.loislaw.com") by vger.kernel.org with ESMTP
	id <S292466AbSBZRs4>; Tue, 26 Feb 2002 12:48:56 -0500
Message-ID: <4188788C3E1BD411AA60009027E92DFD063077D8@loisexc2.loislaw.com>
From: "Rose, Billy" <wrose@loislaw.com>
To: "'Martin Dalecki'" <dalecki@evision-ventures.com>,
        Mike Fedyk <mfedyk@matchmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: RE: ext3 and undeletion
Date: Tue, 26 Feb 2002 11:48:49 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"So the pain for the sysadmin will certainly not be decreased."

My company can tolerate 0% loss of data (which is why I raised this issue).
The sysadmin's pain would be standing in the unemployment line if a file
could not be recovered (which is currently from a heap of tapes that may
take many hours to locate). The issue is not an easier job, but data
integrity. Any sysadmin would state that every user at some point in time
will delete something that is critical. Hell, I've done it myself on my own
workstation after staring at the screen for 15 hours on a Saturday. The
ability to handle situations like a file going "poof" is why my company will
not use Linux on these particular file servers. My aim was to change that by
crushing the only thing holding Netware in my company.

Billy Rose 

-----Original Message-----
From: Martin Dalecki [mailto:dalecki@evision-ventures.com]
Sent: Tuesday, February 26, 2002 10:55 AM
To: Mike Fedyk
Cc: H. Peter Anvin; linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion


Mike Fedyk wrote:
> On Tue, Feb 26, 2002 at 05:36:51PM +0100, Martin Dalecki wrote:
> 
>>>True, and it could to tricks like listing space used for undelete as
"free"
>>>in addition to dynamic garbage collection.
>>>
>>>Though, with a daemon checking the dirs often, or using Daniel's idea of
a
>>>socket between unlink() in glibc and an undelete daemon could work quite
>>>similairly.
>>>
>>>Also, there wouldn't be any interaction with filesystem internals, and
>>>userspace would probably work better with non-posix type filesystems
(vfat,
>>>hfs, etc) too.
>>>
>>>IOW, there seems to be little gain to having an kernelspace solution.
>>>
>>>
>>IMNSHO everyone thinking about undeletion in Linux should be
>>sentenced to 1 year of VMS usage and asked then again if he
>>still think's that it's a good idea...
>>
> 
> Can you describe the pitfalls that VMS went through so we can aviod the
> problems?
> 
> I haven't had the chance to use VMS, and don't have any hardware to try it
> out on.  Also, just because one implementation was bad (even long ago, and
> unix was considered bad then too... ;) does it mean the entire idea is
bad.

Yes I can. The main problem is that most people think that undeletion
is a magical way of getting around stiupid users. But the fact is
that the very same users very quickly adapt to the the presence of
undeletion facilities. And guess whot? They will expect you to
instantly recover allways a version of "this" file from the "stone age".
So the pain for the sysadmin will certainly not be decreased. Quite
contrary for what he expects. For the educated user it was always a pain
in the you know where, to constantly run out of quota space due to
file versioning.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
