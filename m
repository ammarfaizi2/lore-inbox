Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbVAFAMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVAFAMI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 19:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbVAFAMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 19:12:08 -0500
Received: from tartu.cyber.ee ([193.40.6.68]:25358 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S262666AbVAFAMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 19:12:05 -0500
From: "Ville Hallik" <ville@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9+ keyboard LED problem
In-Reply-To: <d120d50005010510543532e0bf@mail.gmail.com>
User-Agent: tin/1.5.12-20020311 ("Toxicity") (UNIX) (Linux/2.4.18-1-686-smp (i686))
Message-Id: <20050106001203.DAD7E14C47@ondatra.tartu-labor>
Date: Thu,  6 Jan 2005 02:12:03 +0200 (EET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <d120d50005010510543532e0bf@mail.gmail.com> you wrote:
> On Wed, 5 Jan 2005 20:38:34 +0200 (EET), Meelis Roos <mroos@linux.ee> wrote:
>> > Seems to work fine here. The led is blinking rapidly but I can type just
>> > fine and touchpad works as well.
>> >
>> > What kind of box do you have? UP/SMP, Preempt?
>> 
>> UP, Celeron 900 on i815. Happens on 2 identical computers, one preempt,
>> one not preempt. PS/2 keyboard and mouse on one, only PS/2 keyboard on
>> the other (and USB mouse that is probably unimportant).
>>

> The big input update went in with 2.6.9-rc2-bk4.Could you try booting
> -bk3 and -bk4 to verify that those changes are to blame?

No, this bug appears with 2.6.9-rc2-bk3. I'm afraid that introduction of
atkbd_schedule_command() & related stuff into atkbd.c is to blame.

-- 

Ville Hallik
