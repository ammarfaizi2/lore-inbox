Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWDTFy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWDTFy0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 01:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWDTFy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 01:54:26 -0400
Received: from web52610.mail.yahoo.com ([206.190.48.213]:33148 "HELO
	web52610.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750709AbWDTFyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 01:54:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wnJ3oe9eXjHmQRPir+007ZPhltRRbywH4tLh4kMUr/8YkINCtg2VpFqEZpBDZ75JvK5aBDc7pa8DrADUzLEq9zQNDsKOdI6nEQYUooTHihYwovZgQcfJB5ZdTnbl6xBDCEp73KRYCRxsncZAYGeo9Sc5ZoyElOZ4wxlEx75AZ2c=  ;
Message-ID: <20060420055422.37845.qmail@web52610.mail.yahoo.com>
Date: Thu, 20 Apr 2006 15:54:22 +1000 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: 2.6.16.1 & D state processes
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1145364422.7515.5.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Mike Galbraith <efault@gmx.de> wrote:
> On Tue, 2006-04-18 at 19:35 +1000, Srihari
> Vijayaraghavan wrote:
> > --- Mike Galbraith <efault@gmx.de> wrote:
> > > On Tue, 2006-04-18 at 15:07 +1000, Srihari
> > > Vijayaraghavan wrote:
> > > > io scheduler cfq registered (default)
> > > ...
> > > Hmm.  Recovers [odd] but takes long time
> [odder]. 
> > > I'd try to eliminate
> > > io scheduler at this point.
> > 
> > Interesting. Considering the minimal .config,
> where I
> > haven't experienced this problem over a week
> uptime,
> > also having CFQ as the default elevator, do you
> still
> > believe CFQ is involved? (I guess if CFQ could be
> > influenced by other kernel configurations, then
> > perhaps another elevator might help. It's worth
> > trying.)
> 
> I don't know that CFQ is involved.  With it
> recovering though, the only
> thing I could think of was a request stucking in the
> io scheduler's
> gizzard for some reason.
> 
> It's just a suggestion, and one you can try without
> even rebooting.

Thanks for that. When it happened today on 2.6.16.7,
I've started using deadline now.

A couple of interesting things I've noticed after its
recovery:
1. Executing "time sleep 1", takes more than 1 second.
It reports real as 3 to 5 seconds, while my stop watch
measures it as closer to 50 seconds.
2. Pressing & holding a key at the console doesn't
produce repeating characters.

Thought they might shed some light on the problem. (I
ought to look at all the RTC & Time related settings
between my minimal .config & FC5's, for I believe
they're connected.)

I haven't rebooted it yet. I'm sure it'll be back to
normal after the reboot.

Thanks

Send instant messages to your online friends http://au.messenger.yahoo.com 
