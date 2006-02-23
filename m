Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWBWMEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWBWMEH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 07:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWBWMEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 07:04:06 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:14093 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750874AbWBWMEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 07:04:05 -0500
Message-ID: <43FDA46E.2000705@openvz.org>
Date: Thu, 23 Feb 2006 15:02:54 +0300
From: Kir Kolyshkin <kir@openvz.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: devel@openvz.org, Kirill Korotaev <dev@sw.ru>,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       Andrey Savochkin <saw@sawoct.com>, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mrmacman_g4@mac.com, Linus Torvalds <torvalds@osdl.org>,
       frankeh@watson.ibm.com, serue@us.ibm.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [Devel] Re: Which of the virtualization approaches is more suitable
 for kernel?
References: <43F9E411.1060305@sw.ru>	<20060220161247.GE18841@MAIL.13thfloor.at> <43FB3937.408@sw.ru>	<20060221235024.GD20204@MAIL.13thfloor.at>	<43FC3853.9030508@openvz.org> <m1zmkjjty6.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1zmkjjty6.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>>Back to the topic. If you (or somebody else) wants to see the real size of
>>things, take a look at broken-out patch set, available from
>>http://download.openvz.org/kernel/broken-out/. Here (2.6.15-025stab014.1 kernel)
>>we see that it all boils down to:
> 
> 
> Thanks.  This is the first indication I have seen that you even have broken-out 
> patches.

When Kirill Korovaev announced OpenVZ patch set on LKML (two times -- 
initially and for 2.6.15), he gave the links to the broken-out patch 
set, both times.

> Why those aren't in your source rpms is beyond me.

That reflects our internal organization: we have a core virtualization 
team which comes up with a core patch (combining all the stuff), and a 
maintenance team which can add some extra patches (driver updates, some 
bugfixes). So that extra patches comes up as a separate patches in 
src.rpms, while virtualization stuff comes up as a single patch. That 
way it is easier for our maintainters group.

Sure we understand this is not convenient for developers who want to 
look at our code -- and thus we provide broken-out kernel patch sets 
from time to time (not for every release, as it requires some effort 
from Kirill, who is really buzy anyway). So, if you want this for a 
specific kernel -- just ask.

I understand that this might look strange, but again, this reflects our 
internal development structure.

> Everything
> seems to have been posted in a 2-3 day window at the end of January and the
> beginning of February.  Is this something you are now providing?

Again, yes, occasionally from time to time, or upon request.

> Shakes head.  You have a patch in broken-out that is 817K.  Do you really
> maintain it this way as one giant patch?

In that version I took (025stab014) it was indeed as one big patch, and 
I believe Kirill maintains it that way.

Previous kernel version (025stab012) was more fine-grained, take a look 
at http://download.openvz.org/kernel/broken-out/2.6.15-025stab012.1

> Please let's not get side tracked playing whose patch is bigger.

Absolutely agree!

Regards,
   Kir Kolyshkin, OpenVZ team.
