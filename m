Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751582AbWIUV3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWIUV3e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWIUV3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:29:34 -0400
Received: from mail.tmr.com ([64.65.253.246]:16859 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1751581AbWIUV3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:29:33 -0400
Message-ID: <45130533.2010209@tmr.com>
Date: Thu, 21 Sep 2006 17:33:39 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19 -mm merge plans
References: <20060920135438.d7dd362b.akpm@osdl.org> <45121382.1090403@garzik.org> <20060920220744.0427539d.akpm@osdl.org> <1158830206.11109.84.camel@localhost.localdomain> <Pine.LNX.4.64.0609210819170.4388@g5.osdl.org> <20060921105959.a55efb5f.akpm@osdl.org> <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

,Linus Torvalds wrote:
> 
> On Thu, 21 Sep 2006, Andrew Morton wrote:
>> Again, before we can implement anything we should describe what problem we are
>> actually trying to solve here.
>>
>> Jeff: "I want faster release cycles because <no reason given>"
>>
>> Me: "I want less bugs"
>>
>> Anyone else?
> 
> Me: "I want peoples expectations to line up".
> 
> (That, btw, is totally independent of this particulay issue - I just like 
> people to know what to expect..)
> 
> One of the things that I think the current model has excelled at is how it 
> really changed peoples behaviour, simply because they knew and understood 
> the rules.
> 
> I think the "big merges in the first two weeks, and a -rc1 after, and no 
> new code after that" rule has been working because it brought everybody in 
> on the same page. 
> 
> I actually expected people to dislike arbitrary rules more than they do, 
> but I've come to believe that people _like_ having rules that they have to 
> obey, as long as it's not a big pain for them. In other words, arbitrary 
> rules are not actually disliked at all, people actually _like_ them, 
> because suddenly there's less need for making unnecessary judgement 
> decisions.
> 
> As an example: I thought I'd get a lot of back-lash on the whole sign-off 
> procedure. Instead, we're basically signing off everything, and having a 
> few simple rules ended up making it just easier to forward stuff, and we 
> haven't had any of the discussions about who gets to be attributed as an 
> author since the sign-off was introduced. That was a totally unexpected 
> bonus, as far as I was concerned.
> 
> The same goes for my anal efforts at trying to make people use a specific 
> format for sending patches, and sending the "please pull" messages. I'm 
> not hearing any grumbling about it at all, and in fact I'm getting the 
> distinct feeling that people like knowing exactly what format to use, 
> because they didn't really care themselves, and it turns out that having 
> any rule - even if it's fairly arbitrary - seems to be better than not 
> having a rule at all.
> 
> So I think that a "odd release"/"even release" rule that clarifies what a 
> certain mid-point in the release cycle actually _means_, even if it 
> doesn't necessarily add anything else, might be a good thing. It just 
> solidifies peoples expectations about where we are in a release cycle.
> 
> If we make an arbitrary rule to go with the release cycle ("leading up to 
> the even cycle, you need to get an ack from somebody that actually tested 
> the fix") that could actually be a good thing, for this reason. 
> 
> I dunno. Maybe the only arbitrary rule ends up being that an "odd release" 
> would become a good place for people to try, knowing that we expect bug 
> reports from them. Right now -rc1 might be _too_ scary, even if it ends up 
> being exactly that: the only difference is really not about technology, 
> but about what peoples expectations are.
> 
> If we could instill a culture of "if you aren't a developer, but you just 
> want to help out, try the odd releases", that in itself might be worth the 
> naming change. If it would allow a group of people who might not feel 
> comfortable about reporting problems with a "-rc" to feel like they are 
> _expected_ to report a problem with an odd release, then that would be a 
> good thing, no?
> 
> I'm just throwing this out as an idea. I'm not going to really argue very 
> strongly for it. It might have horrible downsides too, for all I know, and 
> we might get people who didn't get the memo on "even vs odd releases" 
> being really unhappy about somethign they perceive to be a buggy release.
> 
> 			Linus
I think it would help if you went back to using meaningful names for 
releases, because 2.6.19-test1 is pretty clearly a test release even to 
people who can't figure out if a number is odd or even. Then after 
people stop reporting show stoppers, change to rc numbers, where rc 
versions are actually candidates for release without known major bugs.

Test and rc have pretty clear meanings, anyone who puts a test release 
on a production machine can't complain they didn't know, and people who 
want to wait for the "should not eat your data" stage will be more 
willing to try a release.

Automating testing: someone could write a simple web form to report test 
results (like sign off, sort of). CPU, distribution, network, display, 
filesystems used, that sort of thing. So I say FC4, Radeon-x, HT on X86, 
multiple GigE, port blocking and forwarding, SNAT, TV bttv, DVD burn, 
smbfs, ext3. When N people have reported no issues with a feature, you 
consider it tested. If no one tests something like UML, cryptoloop, nbd, 
Reiser4, or UFS, then you poke the list to try stuff. Or when a change 
goes in, mark it "needs testing" on some web site. In other words 
improve developer <=> tester communication without using a lot of 
someone's time.

I know we have a test tracking system, but I don't see "testers needed" 
messages on the list, and I'm not sure you get or use feedback from any 
test tracking to identify untested features in kernels.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
