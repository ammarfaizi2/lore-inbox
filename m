Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbUCMNHh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 08:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbUCMNHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 08:07:34 -0500
Received: from zero.aec.at ([193.170.194.10]:52486 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263090AbUCMNHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 08:07:10 -0500
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] kref, a tiny, sane, reference count object
References: <1zcH2-KO-11@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 13 Mar 2004 14:06:56 +0100
In-Reply-To: <1zcH2-KO-11@gated-at.bofh.it> (Greg KH's message of "Sat, 13
 Mar 2004 09:30:12 +0100")
Message-ID: <m3y8q4dhfz.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> Comments are appreciated and welcomed.

I really don't see the advantage of this. Writing the same using
atomic_inc/ atomic_dec_and_test() implicitely is basically as clean,
and you will save the overhead of carrying a release() pointer
around. And the "patterns" for that are easy enough that I doubt
people will get it wrong.

-Andi


