Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWAYRIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWAYRIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 12:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWAYRIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 12:08:09 -0500
Received: from mail.gmx.net ([213.165.64.21]:39130 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932073AbWAYRII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 12:08:08 -0500
X-Authenticated: #428038
Message-ID: <43D7B075.6000602@gmx.de>
Date: Wed, 25 Jan 2006 18:08:05 +0100
From: Matthias Andree <matthias.andree@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Joerg Schilling <schilling@fokus.fraunhofer.de>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
In-Reply-To: <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> On Jan 25, 2006, at 11:31, Joerg Schilling wrote:
>> Albert Cahalan <acahalan@gmail.com> wrote:
>>> We Linux users will forever patch your software to work the
>>
>> Looks like you are not a native English speaker. "We" is incorrect 
>> here, as you only speak for yourself.
> 
> I agree completely with his statements, therefore he speaks for at 
> least two people and "we" is proper usage.  I suspect given the posts 
> on this list the last time this flamewar came up that there are more  as
> well, but 2 is enough.
> 
>> libscg includes...
> 
> Irrelevant to the discussion at hand, we are talking only about linux 
> and what should be done on linux.

Well, cdrecord relies on libscg, so in effect most of the portability code
that is affected is in libscg; some of the real-time code however is
specific to cdrecord.

>> - Only 5 of them allow a /dev/hd* device name related access.
> 
> No, you have this wrong:
> 
> - One of them (IE: Linux) requires a /dev/[hs]d* device-name related 
> access

/dev/sd* for CD writing? I think you're off track here. AFAICS cdrecord uses
/dev/sg* to access the writer.

> - Only 4 others allow /dev/hd*
> 
> However, the later is _completely_ _irrelevant_ to the discussion, as 
> we are talking about Linux *only*.

This, and if the code can then be used on other platforms, then there is
little point in calling the Linux /dev/hd* device "badly designed", unless
there were problems with it that prevented cdrecord (or libscg, for pxupdate
or something like that) from working properly.

So I'll repeat my question: is there anything that SG_IO to /dev/hd* (via
ide-cd) cannot do that it can do via /dev/sg*? Device enumeration doesn't count.

The numbers we get from ide-scsi for ATAPI writers are skewed anyhow, I'm
getting 1,0,0 for a SATA hard disk, 2,0,0 for secondary master
DVD-RAM/±R[W], 3,0,0 for secondary slave CD-RW... I wonder why these could
be desirable, and if they are really as static as they pretend to be. I
doubt that, their numbers depend on the order of driver loading.
