Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266130AbUAGEVs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 23:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266131AbUAGEVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 23:21:48 -0500
Received: from pD9E560BB.dip.t-dialin.net ([217.229.96.187]:39332 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S266130AbUAGEVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 23:21:47 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org, Michael.Waychison@Sun.COM
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
From: Andi Kleen <ak@muc.de>
Date: Wed, 07 Jan 2004 05:21:37 +0100
In-Reply-To: <1b6CO-3v0-15@gated-at.bofh.it> ("H. Peter Anvin"'s message of
 "Tue, 06 Jan 2004 22:10:14 +0100")
Message-ID: <m3ad50tmlq.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <1b5GC-29h-1@gated-at.bofh.it> <1b6CO-3v0-15@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

>  A dead daemon is a
> painful recovery, admitted.  It is also a THIS SHOULD NOT HAPPEN
> condition.  By cramming it into the kernel, you're in fact making the
> system less stable, not more, because the kernel being tainted with
> faulty code is a total system malfunction; a crashed userspace daemon is
> "merely" a messy cleanup.  In practice, the autofs daemon/ does not die
> unless a careless system administrator kills it.  It is a non-problem.

I personally would be in favour of doing it all in the kernel because
autofs3 and autofs4 are not fully compatible and break in subtle ways
when not matching and in my experience when you have autofs3 compiled
into the kernel the system happens to have an autofs 4 daemon
installed and vice versa. Doing it in the kernel would avoid this
nasty dependency problem.

Also when /home or other important fs are mounted via autofs there is
not much practical difference between a hung kernel and a hung
daemon. You have to reboot the system anyways.

-Andi
