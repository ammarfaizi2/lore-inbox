Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277725AbRJROjC>; Thu, 18 Oct 2001 10:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277727AbRJROiw>; Thu, 18 Oct 2001 10:38:52 -0400
Received: from fe170.worldonline.dk ([212.54.64.199]:41233 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S277725AbRJROil>; Thu, 18 Oct 2001 10:38:41 -0400
Message-ID: <3BCEE7BF.9090200@eisenstein.dk>
Date: Thu, 18 Oct 2001 16:31:27 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
Organization: Eisenstein
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16 i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: "M. R. Brown" <mrbrown@0xd6.org>
CC: linux-kernel@vger.kernel.org, root@chaos.analogic.com
Subject: Re: Non-GPL modules
In-Reply-To: <Pine.LNX.3.95.1011018091343.32746A-100000@chaos.analogic.com> <20011018090412.I22296@0xd6.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M. R. Brown wrote:

> * Richard B. Johnson <root@chaos.analogic.com> on Thu, Oct 18, 2001:
> 
>> >From time-to-time, I've asked that certain things be allowed
>> within the kernel such as, most recently, denying a raw write
>> to a mounted file-system. Such things have been opposed because,
>> as I have been told, "Policy is not allowed within the kernel...".
>> 
>> Well, with the current GPL code-only fiasco, this is Policy being
>> enforced by the kernel.
>> 
>> It won't be long before we get:
>> 
>> Script started on Thu Oct 18 08:44:44 2001
>> # gcc -o applic xxx.c
>> # ./applic
>> Kernel panic
>> Non GPL application pollution of the Linux environment
>> Application name = ./applic
>>  Virtual address = 0x8048528
>>    Stack address = 0xbffff72c
>>              PID = 32636
>> System halted
>> 
>> I can understand not wanting to take any responsibility for
>> some binary-only module when attempting to find a kernel
>> problem. However, denying the use of non GPL modules is
>> not the way. As a developer of many modules, I can certainly
>> add the required object(s) during development and bypass the
>> current policy. In fact, since the source code of `insmod`
>> is available, it won't be long before any checks put there
>> are eliminated. 
>> 
> 
> I've seen this skewed view being reiterated time and time enough on the
> list to ask,
> 
> Are you people on crack?
> 
> Where is policy being enforced?  insmod spits out a *warning* and procedes
> to taint the kernel.  That's it.  It doesn't prevent such modules from
> being loaded, it doesn't go back on Linus' provision to allow proprietary
> modules, and it doesn't e-mail RMS with the subject "Linux (not GNU/Linux) is
> no longer pure".  

That's how I understand it as well, it does not stop the loading of the 
non GPL module, it just taints the kernel (sets a flag).

> From reading Alan's posts, the primary purpose of this
> provision is to help kernel hackers determine whether it's worth their
> while to follow up on bug reports.  You can only do this with a "pure"
> kernel, since you have no way of knowing if it's something in the
> binary-only module that's killing the kernel.

One thing I don't get is; how does this solve the problem?  As I 
understood it the problem was that people would lie in bug reports and 
say that they had no non-gpl modules loaded even if they did, becourse 
otherwise people would ignore their reports. Tainting the kernel does 
not solve that problem - users who previously lied about loaded modules 
will now just edit the Oops before posting and change the "tainted" 
message to "not tainted". Unless there is some way to validate the "not 
tainted" status of the kernel people are going to continue to lie about 
it.  Would it maybe be possible to generate some kind of "checksum" on 
the taint-state of the kernel that could be verified when recieving the 
oops (probably overkill)?


- Jesper Juhl
  juhl@eisenstein.dk


