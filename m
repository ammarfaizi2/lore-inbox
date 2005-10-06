Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbVJFUNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbVJFUNK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 16:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbVJFUNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 16:13:09 -0400
Received: from rrcs-67-78-243-58.se.biz.rr.com ([67.78.243.58]:58256 "EHLO
	mail.concannon.net") by vger.kernel.org with ESMTP id S1751342AbVJFUNH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 16:13:07 -0400
Message-ID: <4345855B.3@concannon.net>
Date: Thu, 06 Oct 2005 16:13:15 -0400
From: Michael Concannon <mike@concannon.net>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1.centos4 (X11/20050721)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: Chase Venters <chase.venters@clientec.com>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <20051002204703.GG6290@lkcl.net> <200510041840.55820.chase.venters@clientec.com> <20051005102650.GO10538@lkcl.net> <200510060005.09121.chase.venters@clientec.com> <43453E7F.5030801@concannon.net> <20051006192857.GV10538@lkcl.net>
In-Reply-To: <20051006192857.GV10538@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Kenneth Casson Leighton wrote:

>On Thu, Oct 06, 2005 at 11:10:55AM -0400, Michael Concannon wrote:
>
>  
>
>>All good points, but perhaps the most compelling to me is that virtually 
>>every successful windows virus out there does its real damage by 
>>modifying the registry to replace key actions, associate bad actions 
>>with good ones and just generally screw the system up...
>>    
>>
> 
> the damage is done because "admin" rights are forced out of the control
> of the users and sysadmins and into the hands of the dumb-ass app
> writers, for both the setup stage and then the actual day-to-day
> usage of the app!
>
> the registry on NT has ACLs - which are completely irrelevant as far as
> users running as admin are concerned (because the dumb-ass app writers
> force them to).
>
> the nt registry - imagine it to be .... _like_ a filesystem, or _like_
> an LDAP server.
>
> except with proper ACLs and access controls [which everyone bypasses
> because duh it's windows duh, not because it's impossible to do a decent
> job with the API and its implementation].
>  
>
No question that one could limit the damage with various tweaks to 
permissions and access controls, but it is the very centralization of 
information with such vastly disparate purposes (into a single file) 
that is the flaw here...

You can view it, think about it and talk about it as a "file-system" and 
that is fine..  much like /proc or sysfs, but when the system crashes:

1. It _is_ a file: registry.dat
2. It is a binary file at that...
3. That file has become a dumping ground for everything that every app 
thinks is "important" and of course every app writer thinks everything 
they write is the most important thing ever - I am sure a have never 
done such a thing :-)

I guess you could argue that #3 is the fault of the app writers and not 
the architecture, but clearly the current state is the  result of those 
app writers traveling the path of least resistance, so viewed as a whole 
the architecture is to blame regardless...  While it may be wrong for 
people to steal money left on a table out in front of the bank, the bank 
should have  known that this would result and put the money inside...

#2 is an issue because of the complexity of the system which must be 
function to perform the most basic functions of system recovery... 

If you can boot a floppy/pendrive/cd and mount it with vi then it is a 
disk in need of service...

If you cannot, it is a brick in need of re-installation...

I have booted linux a number of times with an NT drive as a slave and 
recovered it.   I have not ever done the inverse...

I hate vi with a passion, more often than not, I have to hit :q! a few 
times before I remember what I have to type, but the fact is, it works 
when nothing else does and it has saved a lot of systems for me...

#2 is also an issue of security because with very simple and reliable 
tools, one can track and monitor changes to key files, one can impose 
any level of security with any level of granularity (perhaps too many 
grains with SELinux, but that is your choice).  Before there was 
tripwire, there were lots of people who wrote basically the same thing 
in plain simple shell/perl scripts and it worked...

#2 is also an issue of backup and restoration...  If it is a 
file-system, it does not provide any useful methods of incremental 
backup and restoration...

There is no equivalent of:
cd etc/xinet.d ; cvs update -A

/etc _is_ a filesystem with all the benefits that come with it...

/tmp is also a great file-system and a much better place to cache all 
that "important" application specific temporary data...  If they want to 
save state, there is:

/etc/<appname>.conf for site-wide setups
~/.<appname> for user-specific state...

I was trying to stay out this thread - clearly I failed :-)  No value 
judgement intended for any of the comments made, this thread is a like a 
car accident on a busy highway...  everyone knows they are slowing 
things down by looking, but they cannot look away...

/mike

> l.
>
>  
>

