Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWBWN2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWBWN2T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 08:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWBWN2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 08:28:19 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19861 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751387AbWBWN2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 08:28:18 -0500
To: Kir Kolyshkin <kir@openvz.org>
Cc: devel@openvz.org, Kirill Korotaev <dev@sw.ru>,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       Andrey Savochkin <saw@sawoct.com>, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mrmacman_g4@mac.com, Linus Torvalds <torvalds@osdl.org>,
       frankeh@watson.ibm.com, serue@us.ibm.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [Devel] Re: Which of the virtualization approaches is more
 suitable for kernel?
References: <43F9E411.1060305@sw.ru>
	<20060220161247.GE18841@MAIL.13thfloor.at> <43FB3937.408@sw.ru>
	<20060221235024.GD20204@MAIL.13thfloor.at>
	<43FC3853.9030508@openvz.org>
	<m1zmkjjty6.fsf@ebiederm.dsl.xmission.com>
	<43FDA46E.2000705@openvz.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 06:25:26 -0700
In-Reply-To: <43FDA46E.2000705@openvz.org> (Kir Kolyshkin's message of "Thu,
 23 Feb 2006 15:02:54 +0300")
Message-ID: <m11wxujjg9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kir Kolyshkin <kir@openvz.org> writes:

> Eric W. Biederman wrote:
>>>Back to the topic. If you (or somebody else) wants to see the real size of
>>>things, take a look at broken-out patch set, available from
>>>http://download.openvz.org/kernel/broken-out/. Here (2.6.15-025stab014.1
> kernel)
>>>we see that it all boils down to:
>> Thanks.  This is the first indication I have seen that you even have
>> broken-out patches.
>
> When Kirill Korovaev announced OpenVZ patch set on LKML (two times -- 
> initially and for 2.6.15), he gave the links to the broken-out patch set, both
> times.
Hmm.  I guess I just missed it.

>> Why those aren't in your source rpms is beyond me.
>
> That reflects our internal organization: we have a core virtualization team
> which comes up with a core patch (combining all the stuff), and a maintenance
> team which can add some extra patches (driver updates, some bugfixes). So that
> extra patches comes up as a separate patches in src.rpms, while virtualization
> stuff comes up as a single patch. That way it is easier for our maintainters
> group.
>
> Sure we understand this is not convenient for developers who want to look at our
> code -- and thus we provide broken-out kernel patch sets from time to time (not
> for every release, as it requires some effort from Kirill, who is really buzy
> anyway). So, if you want this for a specific kernel -- just ask.
>
> I understand that this might look strange, but again, this reflects our internal
> development structure.

There is something this brings up.  Currently OpenVZ seems to be a
project where you guys do the work and release the source under the
GPL.  Making it technically an open source project.  However at the
development level it does not appear to be a community project, at
least at the developer level.

There is nothing wrong with not doing involving the larger community
in the development, but what it does mean is that largely as a
developer OpenVZ is uninteresting to me.

>> Shakes head.  You have a patch in broken-out that is 817K.  Do you really
>> maintain it this way as one giant patch?
>
> In that version I took (025stab014) it was indeed as one big patch, and I
> believe Kirill maintains it that way.
>
> Previous kernel version (025stab012) was more fine-grained, take a look at
> http://download.openvz.org/kernel/broken-out/2.6.15-025stab012.1

Looks a little better yes.  This actually surprises me because my
past experience is that usually well focused patches are easier
to forward port as they usually have fewer collisions and those
collisions are usually easier to resolve.

Eric
