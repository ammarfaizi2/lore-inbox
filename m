Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUITUVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUITUVg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 16:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267303AbUITUVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 16:21:35 -0400
Received: from [205.233.219.253] ([205.233.219.253]:28880 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S266196AbUITUVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 16:21:30 -0400
Date: Mon, 20 Sep 2004 16:20:46 -0400
From: Jody McIntyre <realtime-lsm@modernduck.com>
To: "Jack O'Quin" <joq@io.com>
Cc: torbenh@gmx.de, James Morris <jmorris@redhat.com>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20040920202046.GH4273@conscoop.ottawa.on.ca>
References: <20040916023118.GE2945@conscoop.ottawa.on.ca> <87d60mrf8i.fsf@sulphur.joq.us> <20040916155127.GG2945@conscoop.ottawa.on.ca> <87zn3qoyrt.fsf@sulphur.joq.us> <20040917070857.GB4476@mobilat.informatik.uni-bremen.de> <87hdpwpsvx.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hdpwpsvx.fsf@sulphur.joq.us>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 03:01:06PM -0500, Jack O'Quin wrote:

> I was thinking that it could drop root privileges and try creating a
> realtime thread.  But, then I realied it would be better (and simpler)
> for `jackstart' to exec `jackd' unconditionally, even when the
> required capabilities are not available.  Let `jackd' figure out for
> itself what it can actually do.

I agree.  jackstart should always call jackd.  I ran into a similar
problem a few weeks ago when I gave a demo on my laptop and didn't have
time to patch my kernel.  I wasn't doing any serious recording so I
thought I'd run without -R.  Of course, that didn't work until I changed
qjackctl to use 'jackd' as a command rather than 'jackstart'.  This
could be a serious problem for a less experienced user.

Jody

> That is what I meant about trying the operation being the only
> reliable test.  Jackstart should not give up just because one
> privilege mechanism is unavailable.  It cannot know all the possible
> reasons why jackd might or might not have access to realtime
> resources.  Its job is simply to pass the capabilities if they are
> available.
> -- 
>   joq

-- 
