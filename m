Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbVCDEN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbVCDEN7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 23:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbVCDEM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 23:12:56 -0500
Received: from warden2-p.diginsite.com ([209.195.52.120]:35502 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262639AbVCCV6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:58:08 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@davemloft.net>,
       akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>
Date: Thu, 3 Mar 2005 13:53:26 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <1109886108.591.58.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0503031349470.29190@qynat.qvtvafvgr.pbz>
References: <42265A6F.8030609@pobox.com><20050302165830.0a74b85c.davem@davemloft.net>
 <422674A4.9080209@pobox.com><Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org><42268749.4010504@pobox.com>
 <20050302200214.3e4f0015.davem@davemloft.net><42268F93.6060504@pobox.com>
 <4226969E.5020101@pobox.com><20050302205826.523b9144.davem@davemloft.net>
 <4226C235.1070609@pobox.com><20050303080459.GA29235@kroah.com>
 <4226CA7E.4090905@pobox.com><Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org><422751C1.7030607@pobox.com><Pine.LNX.4.58.0503031022100.25732@ppc970.osdl.org><1109883750.591.47.camel@localhost.localdomain><Pine.LNX.4.62.0503031321140.29190@qynat.qvtvafvgr.pbz>
 <1109886108.591.58.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005, Steven Rostedt wrote:

> On Thu, 2005-03-03 at 13:24 -0800, David Lang wrote:
>
>> I don't think you are understanding the proposal
>>
> You're probably right. :-)
>
>> 2.6.11.y will be released as 2.6.12 is being developed.
>>
>> once 2.6.12 is released (or shortly after that if 2.6.12 ends up being a
>> _real_ mess) 2.6.11.y will not get any additional releases (2.6.12.y will
>> get released instead)
>>
>> as a result there will be no backports at all. if you want a feature
>> that's introduced in 2.6.12 then you wait until you get a 2.6.12.y release
>> that's good enough for you.
>>
> I understand the no backports.  That's a good thing.  That's what I was
> trying to state (but was probably too long winded!).  Lets see if this
> is what I believe is being proposed.
>
> 2.6.x would be the release with some number of features added.
>
> 2.6.x.y would include bug fixes only, that are under the strong rule of
> Linus to only be things that crash/hang the machine or nasty security
> exploits.
>
> 2.6.x+1 would be 2.6.x.(some y) also including features (from -rc or
> -mm)
>
> 2.6.x.z (where z is greater than the above "some y") only include the
> same level of fixes as with 2.6.x.y, with the parallel work of 2.6.x+1
> still going on.
>
> Please correct me if I'm wrong here.

this sounds like what I am understanding.

>> also I think the expectation is that there aren't going to be more then
>> 2-3 2.6.x.y releases so your comment of people waiting until y>5 won't
>> apply
>>
>
> Say after 2.6.x.3 has been released and 2.6.x+1 is now out, and someone
> finds a rare race condition that hangs the machine.  A 2.6.x.4 would not
> be released?

my understanding is that in general there would no be a 2.6.x.4 in this 
case (special cases can cause rules to be bent, a rare race condition 
probably wouldn't qualify, a remote root security hole probably would)

> Actually, the >5 was pretty pointless anyway.  What I got
> from talking to people is that they wanted a release that only got fixes
> that would crash the machine, or cause a root exploit. That's what I
> thought Linus was trying to say.

the trouble is that 'crash the machine' can include a HUGE number of the 
fixes that go into 2.6.x+1 and you just lost stability again

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
