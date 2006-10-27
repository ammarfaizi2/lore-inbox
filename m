Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWJ0USJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWJ0USJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 16:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWJ0USJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 16:18:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:61262 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751036AbWJ0USH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 16:18:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=bHOWvypR4KVa3MzMYM682yaRMvMqiZ/w06+1yXxQ7p2lHeALdua5AyFNAQ9zNjlBg/EBxQgG3sgb95em2QEwvFRg9XBnFvJEYEB/pYyiSpf/VR1wZs4oG19cEJFKbSS1xtbQ7zUb/stYBjzXlGUcPROV7hQxtbMUqcFx14K4YpA=
Date: Fri, 27 Oct 2006 22:18:20 +0200
From: Luca Tettamanti <kronos.it@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061027201820.GA8394@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161969308.27225.120.camel@mindpipe>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> ha scritto:
> Someone recently pointed out to me that a Windows "CPU driver update"
> supplied by AMD fixes the unsynced TSC problem on dual core AMD64
> systems.
[...]
> other incorrect timing effects that these applications may experience on
> dual-core processor systems, by periodically adjusting the core
> time-stamp-counters, so that they are synchronized."
> 
> What are the chances of Linux getting a similar fix?

Zero? ;)
There's always a window where the TSCs are not in sync (and userspace may
see a non-monotonic counter); furthermore when C'n'Q is active TSCs
aren't updated at a fixed frequency, userspace cannot use TSC for timing
anyway.


Luca
-- 
> While we're on all of this, are we going to change "tained" to some
> other less alarmist word?
"screwed" -- Alexander Viro
