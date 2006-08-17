Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWHQVXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWHQVXm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 17:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWHQVXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 17:23:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:52590 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932281AbWHQVXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 17:23:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Henuhd8bEfBM5fohFEUqsDiHq8N7AGxDvbILUz6lKpLJRZ0ptcjlwQBaU8O6iVLxCa+84dVU559qPR0ai6CwE0UH7b1tO488vAYafF3OPtDZyrLiQ6LHjRfBW9F5tED3by0dZgN+aFJ1eyw62/b67B02i/hEN4hBDYAK/6e2tfY=
Message-ID: <9a8748490608171423w3e5f7007nf92fad74637f0dd3@mail.gmail.com>
Date: Thu, 17 Aug 2006 23:23:39 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Nathan Scott" <nathans@sgi.com>
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
In-Reply-To: <20060816112630.C2756824@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490608100431m244207b1v9c9c5087233fcf3a@mail.gmail.com>
	 <9a8748490608101544n29f863e7o7584ac64f1d4c210@mail.gmail.com>
	 <9a8748490608101552w12822fa6m415a5fb5537c744d@mail.gmail.com>
	 <9a8748490608110133v5f973cf6w1af340f59bb229ec@mail.gmail.com>
	 <9a8748490608110325k25c340e2yac925eb226d1fe4f@mail.gmail.com>
	 <20060814120032.E2698880@wobbly.melbourne.sgi.com>
	 <9a8748490608140049t492742cx7f826a9f40835d71@mail.gmail.com>
	 <20060815190343.A2743401@wobbly.melbourne.sgi.com>
	 <9a8748490608150442q4ad7a835r53400e9880da3175@mail.gmail.com>
	 <20060816112630.C2756824@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/06, Nathan Scott <nathans@sgi.com> wrote:
> On Tue, Aug 15, 2006 at 01:42:27PM +0200, Jesper Juhl wrote:
> > On 15/08/06, Nathan Scott <nathans@sgi.com> wrote:
> > > If you can get the source
> > > and target names in the rename that'll help alot too... I can
> > > explain how to use KDB to get that, but maybe you have another
> > > debugger handy already?
> > >
> > An explanation of how exactely to do that would be greatly appreciated.
>
> - patch in KDB
> - echo 127 > /proc/sys/fs/xfs/panic_mask
> [ filesystem shutdown now == panic ]
> - kdb> bt
> [ pick out parameters to rename from the backtrace ]
> - kdb> md 0xXXX
> [ gives a memory dump of the pointers to pathnames ]
>

Thanks a lot for the explanation.

Unfortunately I didn't get a chance to run new tests on the server
this week (always the big problem when it's a production machine).
I'm also going on a short vacation, so I won't have the oppotunity to
try and recreate a simpler test case at home for the next few days.

When I get back (in some 4 days time) I'll try to build a more simple
test case and in about a week or so I hopefully will get a new chance
to run new tests on the server that has so far shown the problem.
If there are additional tests you want me to run or data you want me
to collect, then let me know and I'll do so the first chance I get.

I'll be back in touch in ~1 weeks time.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
