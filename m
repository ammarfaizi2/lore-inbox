Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWI3WTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWI3WTo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWI3WTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:19:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:63426 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751461AbWI3WTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:19:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HGdxV5flR9zXv406uhyfa13fmuP+LpNXc1ZQCXzDwC6AnlwJJHPFvWm61l6Zo5PaX1xp0nntfpWRSzghHIDrq52uuLJ1/SWCnHJZ8WX8T//gh6qNXvNb0amjZ9ZegGcHofbVxSmwCq2LuXngGs8MP4ejvsU87fh1z61FXBPd+Ps=
Message-ID: <5f3c152b0609301519p42250850ufe02a79364249622@mail.gmail.com>
Date: Sun, 1 Oct 2006 00:19:41 +0200
From: "Eric Rannaud" <eric.rannaud@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18) II
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, nagar@watson.ibm.com,
       "Chandra Seetharaman" <sekharan@us.ibm.com>,
       "Jan Beulich" <jbeulich@novell.com>
In-Reply-To: <200610010009.30123.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
	 <Pine.LNX.4.64.0609301406340.3952@g5.osdl.org>
	 <200609302357.06215.ak@suse.de> <200610010009.30123.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/06, Andi Kleen <ak@suse.de> wrote:
> I double checked this now. This case Eric ran into should be already
> fixed by a patch from Jan that went in before 2.6.18 even.
>
> He just ran with an old kernel (2.6.18-rc3) that didn't have
> that particular fix.

Hmm, not sure I'm following you, but I did try with the released
v2.6.18 (fourth stacktrace in my first email in this thread). The
2.6.13-rc3 (d94a041519f3ab1ac023bf917619cd8c4a7d3c01) version was
tested only as the result of git-bisect, and is the first kernel that
crashed in this way. But v2.6.18 crashed in a similar way as well.
Are you saying v2.6.18 should contain a fix preventing it from crashing?

> Still the kernel stack termination is probably a good idea. I think
> (haven't tested) the current 2.6.18-git* code with termination
> wouldn't have crashed, but reported a (incorrect) stuck.

Making sure my post was clear: that's what v2.6.18 + termination does.

Sorry if I misunderstood you.

er.
