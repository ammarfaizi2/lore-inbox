Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161084AbWFKF01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161084AbWFKF01 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 01:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbWFKF01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 01:26:27 -0400
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:2255 "EHLO
	elasmtp-banded.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1161084AbWFKF01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 01:26:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=I2Uh24xp5U4DSQAb9onTC4zHgMYNPmeZ25k0+b+lrvALQPaWh2TnCve3aaNsHGAW;
  h=Received:Message-ID:From:To:Cc:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MimeOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <193f01c68d17$92570ae0$0225a8c0@Wednesday>
From: "jdow" <jdow@earthlink.net>
To: "Neil Brown" <neilb@suse.de>, "David Woodhouse" <dwmw2@infradead.org>
Cc: "Matti Aarnio" <matti.aarnio@zmailer.org>, <linux-kernel@vger.kernel.org>
References: <20060610222734.GZ27502@mea-ext.zmailer.org><1149980791.18635.197.camel@shinybook.infradead.org> <17547.42403.669502.694618@cse.unsw.edu.au>
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
Date: Sat, 10 Jun 2006 22:26:19 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b571120b4d35498f734f7adfd5425c3d7a80221c078aea63b72d6fc350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.167.175
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Neil Brown" <neilb@suse.de>

> On Sunday June 11, dwmw2@infradead.org wrote:
>> On Sun, 2006-06-11 at 01:27 +0300, Matti Aarnio wrote:
>> > Now that there is even an RFC published about SPF...
>> 
>> Please, don't do this. SPF makes assumptions about email which are just
>> not true; it rejects perfectly valid mail.
>> 
>> http://david.woodhou.se/why-not-spf.html
> 
> Conversely, please do do this :-)
> 
> I agree with David that SPF breaks mail-as-we-know-it, but I cannot
> help thinking that mail-as-we-know-it is way too permissive and bits
> of it need to be broken (the old egg/omelette analogy).
> 
> And I think that kernel.org is a great place to start with pushing
> SPF, because if a few mail items go astray to-or-from it really isn't
> the end of the world.
> 
> - kernel.org should publish very strict SPF records that sites with
>  any gumption can reject forged mail claiming to be from kernel.org.
>  If systems drop mail incorrectly because of this, the end-recipient
>  can follow linux-kernel any number of other ways, and can badger
>  their local admins to "get it right".

Sir, I've been doing this for years already using primary source
information - the trackable message headers. So far forgeries are
not a problem. It becomes quite obvious when a message has forged
headers, obvious enough automated analysis works remarkably well.

> - kernel.org should reject mail that earns an SPF 'fail' and should
>  grey-list mail that earns an SPF 'softfail' (so the sending system
>  will have to retry once). Any mail that incorrectly gets rejected
>  will hopefully have a link to a web page that explains the problem
>  and lists a number of free-mail sites where anyone can sign up and
>  safely send mail to kernel.org.  So people who need to get mail
>  through still can, while they complain to their admins about
>  configuring things properly.

No sir. FAIL and SOFT_FAIL prove nothing. PASS proves remarkably
little. SPF is not a good criterion for much of anything.

> I think kernel.org is a great site to be an early adopter because:
>  - the mail it transports isn't critical
>  - it interacts with a very large number of mail sites
>  - it's customers are reasonably technology-savvy. 

It would be a good site to adopt it outgoing. But adopting it as an
incoming message filter is silly.

> sourceforge would be another good site.
> 
> 
> (No, SPF doesn't stop spam, but it can increase accountability so that
> white/black lists can begin to be more usable).

It does not even do that conclusively. Many of us wish it did. But if
a spammer can post his own spf records he can claim what he wants
about email sources. DNS cache poisoning attacks assure that this can
take place even for sites you might control.

{^_^}   Joanne Dow said that. Seriously, I recommend a pass through the
        old SpamAssassin users mailing list for past discussions. An
        SPF_HELO_SOFTFAIL is the only thing given a sizeable score.
