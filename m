Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbVJOH4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVJOH4c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 03:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVJOH4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 03:56:32 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:3872 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751126AbVJOH4c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 03:56:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T7OZKnExT6tzHHRoUPCkxQQ1d6kPPvDgyrtkguxwKM3/vSNBVUVU8iIQYMfMqne/w0FgLBKkHvidgQuzWEm7/7RWSb+WtEs46PytlKJ3i0vn+s1geNLs2jIkylUUQlAgm87576adzsSqPpyhiNucp4WkJk3CNCTJmm81bPwaqtE=
Message-ID: <2cd57c900510150056j2a6af6e5gf93ce9fa4ef16aac@mail.gmail.com>
Date: Sat, 15 Oct 2005 15:56:31 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Forcing an immediate reboot
Cc: Lee Revell <rlrevell@joe-job.com>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0510150846430.25927@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43505F86.1050701@perkel.com> <1129341050.23895.12.camel@mindpipe>
	 <Pine.LNX.4.64.0510150846430.25927@hermes-1.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/05, Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> On Fri, 14 Oct 2005, Lee Revell wrote:
> > On Fri, 2005-10-14 at 18:46 -0700, Marc Perkel wrote:
> > > Is there any way to force an immediate reboot as if to push the reset
> > > button in software? Got a remote server that i need to reboot and
> > > shutdown isn't working.
> >
> > If it has Oopsed, and the "reboot" command does not work, then all bets
> > are off - kernel memory has probably been corrupted.
> >
> > Get one of those powerstrips that you can telnet into and power cycle
> > things remotely.
>
> If it has sysrq compiled in as root just do:
>
> echo s > /proc/sysrq-trigger
> echo u > /proc/sysre-trigger
> echo s > /proc/sysrq-trigger

What the purpose of the second sync?

> echo b > /proc/sysrq-trigger
>
> This will "sync", "umount/remount read-only", "sync", "immediate hardware
> reboot".  Should always work...
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
