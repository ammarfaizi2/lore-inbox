Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751624AbWIGWqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbWIGWqt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 18:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbWIGWqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 18:46:49 -0400
Received: from relay02.pair.com ([209.68.5.16]:12040 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751624AbWIGWqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 18:46:48 -0400
X-pair-Authenticated: 71.197.50.189
Date: Thu, 7 Sep 2006 17:37:16 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: Chase Venters <chase.venters@clientec.com>, ellis@spinics.net,
       w@1wt.eu (Willy Tarreau), linux-kernel@vger.kernel.org
Subject: Re: bogofilter ate 3/5
In-Reply-To: <m3lkovs3vv.fsf@defiant.localdomain>
Message-ID: <Pine.LNX.4.64.0609071726200.31500@turbotaz.ourhouse>
References: <200609061856.k86IuS61017253@no.spam>
 <Pine.LNX.4.64.0609061409360.18840@turbotaz.ourhouse> <m34pvkvhm0.fsf@defiant.localdomain>
 <Pine.LNX.4.64.0609061658440.18840@turbotaz.ourhouse> <m37j0fvqkq.fsf@defiant.localdomain>
 <Pine.LNX.4.64.0609070834180.31500@turbotaz.ourhouse> <m3lkovs3vv.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006, Krzysztof Halasa wrote:

> Chase Venters <chase.venters@clientec.com> writes:
>
>> The problem with trying to stop forgery is that there is not yet a
>> foolproof or reasonably foolproof method of doing so.
>
> The first important point here is that vger rejects mail in SMTP
> DATA phase, thus making the forgery irrelevant WRT such bounces.
> Second, being on the list isn't enough for the message to go
> through, it has to pass the filters as everyone else.
>

Fair enough. The discussion drifted with the introduction of the SpamCop 
idea that bounce messages are evil. As you have shown, it is possible in 
many instances to refuse mail at the door; however, it's pretty unfeasible 
in many environments...

>
> Third, while I think "normal" autoresponders (vacation etc.)
> are perfectly reasonable (not in mailing list context of course),
> ones which by design respond mostly to forged addresses (do you
> think antivirus and antispam qualify?) are aimed at the wrong,
> innocent person.
>

Well, this is an interesting point applicable to my specific suggestion. 
You are right that such a script would generate a lot of misdirected mail. 
In my experience in dealing with this issue, it's usually e-mail viruses 
that spoof legitimate addresses: most of the spam I see comes from junk 
addresses at junk domains. So it's not like you're bugging a *human*.

In any case, this specific idea was just a brainstorm for how we could 
use X-Bogofilter: headers to allow LKML subscribers to make their own 
filtering decision about the messages. Another idea is to divert junk mail 
to a second list which is for people that want to be real sure they don't 
miss patches.

A third choice is obviously to leave the problem alone and let bogofilter 
eat our patches ;)

Whichever route is taken, though, it looks like we might have to switch 
away from Majordomo soon, because SpamCop and Stuart MacDonald are going 
to bring an end to programs that automatically respond to mail.

Thanks,
Chase
