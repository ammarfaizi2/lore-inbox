Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbVI3AxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbVI3AxG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVI3AxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:53:06 -0400
Received: from aramaki.bong.com.au ([203.91.232.99]:61687 "EHLO
	aramaki.bong.com.au") by vger.kernel.org with ESMTP id S932516AbVI3AxE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:53:04 -0400
Message-ID: <2805.203.91.245.98.1128042043.squirrel@webmail.bong.com.au>
In-Reply-To: <1128040019.31197.3.camel@gaston>
References: <1127978432.6102.53.camel@gaston>  <433C7882.20000@am.sony.com>
    <1128040019.31197.3.camel@gaston>
Date: Fri, 30 Sep 2005 11:00:43 +1000 (EST)
Subject: Re: iMac G5: experimental thermal & cpufreq support
From: "Dean Hamstead" <dean@bong.com.au>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: "Geoff Levand" <geoffrey.levand@am.sony.com>, linuxppc64-dev@ozlabs.org,
       "linuxppc-dev list" <linuxppc-dev@ozlabs.org>,
       "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although i dont have an imac g5, i think that in general ben is on the
right track. its better to have something in place than nothing.

not putting down the feedback, but im not sure just how much fiddling
people will really want, and its not a huge audience. which
brings me back to the point of just getting something in place and
then people can change it as IMO linux kernel code is more likely to be
fiddled with (and better 'documentation' - whatever that is) than darwin
code.

go ben, keep working hard. and keep chasing the mpeg decoder in the ati
cards of apple ibook and friends!

Dean

On Fri, September 30, 2005 10:26 am, Benjamin Herrenschmidt said:
> On Thu, 2005-09-29 at 16:28 -0700, Geoff Levand wrote:
>> Benjamin Herrenschmidt wrote:
>> > The algorithm itself is extracted from darwin. However, it's a rather
>> > complex modified version of the PID algorithm, and thus it could use
>> > some review to make sure I got everything right.
>> >
>>
>> As we are already in the digital domain, I would think it would be
>> more savvy to use a digital controller than try to simulate an
>> analog controller...  Why don't you abstract the control algorithm
>> such that you can plug in others as they are developed.
>
> Because I don't know much about those control algorithms, and all the
> calibration data provided by the firmware is in the form of factors for
> these algorithms, I wouldn't know how to "unmangle" them to use with
> different ones.
>
> Actually, the control algorithms (PID and modified PID) are in a
> "helper", so it's fairly easy for the platform module to use whatever it
> wants, feel free to submit other algorithms :) But for Apple machines,
> I'd rather use what I have calibration data for, unless you can produce
> something that works without any...
>
> Ben.
>
>
> --
> To UNSUBSCRIBE, email to debian-powerpc-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact
> listmaster@lists.debian.org
>
>

