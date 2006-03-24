Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWCXT1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWCXT1E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWCXT1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:27:04 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28376 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964793AbWCXT1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:27:03 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org, herbert@13thfloor.at,
       devel@openvz.org, serue@us.ibm.com, akpm@osdl.org, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 24 Mar 2006 11:36:18 -0700
In-Reply-To: <44242A3F.1010307@sw.ru> (Kirill Korotaev's message of "Fri, 24
 Mar 2006 20:19:59 +0300")
Message-ID: <m1d5gbk7vh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

> Eric, Herbert,
>
> I think it is quite clear, that without some agreement on all these
> virtualization issues, we won't be able to commit anything good to
> mainstream. My idea is to gather our efforts to get consensus on most clean
> parts of code first and commit them one by one.
>
> The proposal is quite simple. We have 4 parties in this conversation (maybe
> more?): IBM guys, OpenVZ, VServer and Eric Biederman. We discuss the areas which
> should be considered step by step. Send patches for each area, discuss, come to
> some agreement and all 4 parties Sign-Off the patch. After that it goes to
> Andrew/Linus. Worth trying?

Yes, this sounds like a path forward that has a reasonable chance of
making progress.

> So far, (correct me if I'm wrong) we concluded that some people don't want
> containers as a whole, but want some subsystem namespaces. I suppose for people
> who care about containers only it doesn't matter, so we can proceed with
> namespaces, yeah?

Yes, I think at one point I have seen all of the major parties receptive
to the concept.

> So the most easy namespaces to discuss I see:
> - utsname
> - sys IPC
> - network virtualization
> - netfilter virtualization

The networking is hard simply because the is so very much of it, and it
is being active developed :)

> all these were discussed already somehow and looks like there is no fundamental
> differencies in our approaches (at least OpenVZ and Eric, for sure).

Yes.  I think we agree on what the semantics should be for these parts.
Which should avoid the problem with have with the pid namespace.

> Right now, I suggest to concentrate on first 2 namespaces - utsname and
> sysvipc. They are small enough and easy. Lets consider them without sysctl/proc
> issues, as those can be resolved later. I sent the patches for these 2
> namespaces to all of you. I really hope for some _good_ critics, so we could
> work it out quickly.

Sounds like a plan.

Eric
