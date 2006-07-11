Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWGKTJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWGKTJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWGKTJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:09:58 -0400
Received: from mail.gmx.net ([213.165.64.21]:48029 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932096AbWGKTJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:09:57 -0400
X-Authenticated: #5039886
Date: Tue, 11 Jul 2006 21:09:49 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Joshua Hudson <joshudson@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] 'volatile' in userspace
Message-ID: <20060711190949.GA8373@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Joshua Hudson <joshudson@gmail.com>, linux-kernel@vger.kernel.org
References: <44B0FAD5.7050002@argo.co.il> <MDEHLPKNGKAHNMBLJOLKMEPGNAAB.davids@webmaster.com> <20060709195114.GB17128@thunk.org> <20060709204006.GA5242@nospam.com> <20060710034250.GA15138@thunk.org> <bda6d13a0607101000w6ec403bbq7ac0fe66c09c6080@mail.gmail.com> <44B29461.40605@yahoo.com.au> <Pine.LNX.4.61.0607110945580.30961@yvahk01.tjqt.qr> <44B39151.10600@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44B39151.10600@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.07.11 21:53:53 +1000, Nick Piggin wrote:
> Jan Engelhardt wrote:
> >>What's wrong with _exit(exec() == -1 ? 0 : errno);
> >>and picking up the status with wait(2) ?
> >>
> >
> >The exec'd application may return regular error codes, which would 
> >interfere. IIRC /usr/sbin/useradd has different exit codes depending on 
> >what failed (providing some option, failure to create account, failure to 
> >create home dir, etc.). Now if you exit(errno) instead, you have an 
> >overlap.
> 
> You're right. Maybe you could return -ve or with a high bit set,
> but I guess you may not know what the app will return.
> 
> But I don't see how the volatile or pipe solutions are any better
> though: it would seem that both result in undefined behaviour
> according to my vfork man page. At least the wait() solution is
> defined (and workable, if you know what the target might return).

The volatile solution is buggy according to the vfork man page, but the
pipe solution is fine, it doesn't use vfork at all ;)

Björn
