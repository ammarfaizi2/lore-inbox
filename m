Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWHVAVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWHVAVh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 20:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWHVAVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 20:21:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:31148 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750845AbWHVAVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 20:21:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tsQRKcP8KbOB7ZW5A5EtvFGXXKWcsIbCbaPPQqkE3RzwdhgLJNw9SuAhCZCDWWV2nSJ/7B9f7A6S45PiF+rL9ebKmbCURHGn/pb9Gu90at5REHU1yOzRvLaR1pPix7gjzfqTycB6O/oWblXZUX5N004Nhc+163LTBWyPbqyvvx8=
Message-ID: <e6babb600608211721g739c5518sa14427d1e9f2334@mail.gmail.com>
Date: Mon, 21 Aug 2006 17:21:35 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "hui Bill Huey" <billh@gnuppy.monkey.org>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re: Problems with 2.6.17-rt8
Cc: "Esben Nielsen" <nielsen.esben@googlemail.com>,
       "Ingo Molnar" <mingo@elte.hu>, "Thomas Gleixner" <tglx@linutronix.de>,
       rostedt@goodmis.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060818115934.GA29919@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060808030524.GA20530@gnuppy.monkey.org>
	 <20060810021835.GB12769@gnuppy.monkey.org>
	 <20060811010646.GA24434@gnuppy.monkey.org>
	 <e6babb600608110800g379ed2c3gd0dbed706d50622c@mail.gmail.com>
	 <20060811211857.GA32185@gnuppy.monkey.org>
	 <20060811221054.GA32459@gnuppy.monkey.org>
	 <e6babb600608141056j4410380fr15348430738c91d8@mail.gmail.com>
	 <20060814234423.GA31230@gnuppy.monkey.org>
	 <e6babb600608151053u6b902b80k9e3b399fe34ee10f@mail.gmail.com>
	 <20060818115934.GA29919@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:
> Patch attached:

The problem still appears to happen, but now I get no trace at all,
just a single line reported to the machine's console (and not on the
serial console):

pdflush/314[CPU#2]: BUG in debug_rt_mutex_unlock at kernel/rt_mutex_debug.c:471

i.e., a standard statement, except at pdflush instead of swapper this time.

-- 
Robert Crocombe
rcrocomb@gmail.com
