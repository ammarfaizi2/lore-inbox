Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbTKZTeR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 14:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbTKZTeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 14:34:17 -0500
Received: from dsl-sj-66-219-74-27.broadviewnet.net ([66.219.74.27]:3715 "EHLO
	server.perens.com") by vger.kernel.org with ESMTP id S264288AbTKZTeN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 14:34:13 -0500
Message-ID: <3FC50029.7030706@perens.com>
Date: Wed, 26 Nov 2003 11:34:01 -0800
From: Bruce Perens <bruce@perens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Posix says "undefined". Re: Signal left blocked after signal handler.
References: <20031126173953.GA3534@perens.com> <Pine.LNX.4.58.0311260945030.1524@home.osdl.org> <3FC4ED5F.4090901@perens.com> <3FC4EF24.9040307@perens.com> <3FC4F248.8060307@perens.com> <Pine.LNX.4.58.0311261037370.1524@home.osdl.org> <3FC4F94F.6030801@perens.com> <Pine.LNX.4.58.0311261108350.1524@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0311261108350.1524@home.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Posix says the behavior is undefined. See 
http://www.opengroup.org/onlinepubs/007904975/functions/sigprocmask.html .
I think it makes sense to leave the 2.6 behavior as it is.

    Thanks

    Bruce

Linus Torvalds wrote:

> I personally think it is "good taste" to actually set the SA_NODEFER flag

> if you know you depend on the behaviour, but if there are lots of existing
>
>applications that actually depend on the "forced punch-through" behaviour,
>then I'll obviously have to change the 2.6.x behaviour (a stable
>user-level ABI is a lot more important than my personal preferences).
>
>But if ElectricFence is the only thing that cares, I'd rather just EF
>added a SA_NODEFER..
>  
>


