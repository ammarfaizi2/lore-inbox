Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291484AbSBABhk>; Thu, 31 Jan 2002 20:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291485AbSBABha>; Thu, 31 Jan 2002 20:37:30 -0500
Received: from zok.sgi.com ([204.94.215.101]:64976 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S291484AbSBABhY>;
	Thu, 31 Jan 2002 20:37:24 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Larry McVoy <lm@bitmover.com>
Cc: Troy Benjegerdes <hozer@drgw.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin 
In-Reply-To: Your message of "Thu, 31 Jan 2002 17:04:28 -0800."
             <20020131170428.V1519@work.bitmover.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Feb 2002 12:37:15 +1100
Message-ID: <23817.1012527435@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002 17:04:28 -0800, 
Larry McVoy <lm@bitmover.com> wrote:
>On Fri, Feb 01, 2002 at 11:29:58AM +1100, Keith Owens wrote:
>> That sounds almost like what I was looking for, with two differences.
>> 
>> (1) Implement the collapsed set so bk records that it is equivalent to
>>     the individual patchsets.  Only record that information in my tree.
>>     I need the detailed history of what changes went into the collapsed
>>     set, nobody else does.
>> 
>> (2) Somebody else creates a change against the collapsed set and I pull
>>     that change.  bk notices that the change is again a collapsed set
>>     for which I have local detail.  The external change becomes a
>>     branch off the last detailed patch in the collapsed set.
>
>This is certainly possible to do.  However, unless you are willing to fund
>this development, we aren't going to do it.  We will pick up the costs of
>making changes that you want if and only if we have commercial customers
>who want (or are likely to want) the same thing.  Nothing personal, it's
>a business and we make tradeoffs like that all the time.

Understood.

>Collapsing is relatively easy, it's tracking the same content in two
>different sets of deltas which is hard to get exactly correct.  Certainly
>possible but I can visualize what it would take and it would be messy and
>disruptive to the source base for an obscure feature that is unlikely to
>be used.
>
>Why don't you actually use BK for a while and see if you really think
>you need this feature.  The fact that our customers aren't clamoring for
>it should tell you something.  They do work as hard and on as much code
>(in many cases on the same code) as you do.

This is the way that I use PRCS now and it fits the diff/patch model
for distributing kernel code that most people are used to, while
reducing the concerns about information overload.

With PRCS I have branches galore with lots of little changes.  The
outside world sees complete patch sets, not the individual changes.
When they send a patch back I work out which internal change it is
against and start a new branch against it.  The downside with PRCS is
that the creation of the patch set and storing on an ftp site is a
manual process, as is identifying which internal change a patch
response is against and starting a new branch against the last internal
change.

If bk could automate the creation and tracking of meta patchsets I
would convert tomorrow, the ability to automatically distribute changes
is what I miss in PRCS.  But if using bk means that I cannot
automatically separate and track the internal and external patches then
there is no benefit to me in converting.  If I have to clone a
repository to roll up internal patches into an external set and I
cannot automatically pull changes against the external set back into my
working repository then bk gives me no advantages.

