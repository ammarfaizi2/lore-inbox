Return-Path: <linux-kernel-owner+w=401wt.eu-S1750788AbXACORZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbXACORZ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 09:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbXACORY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 09:17:24 -0500
Received: from [217.111.56.2] ([217.111.56.2]:46094 "EHLO semtex.sncag.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750788AbXACORY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 09:17:24 -0500
To: Greg KH <greg@kroah.com>
Cc: Rainer Weikusat <rweikusat@sncag.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] fix for bugzilla #7544 (keyspan USB-to-serial converter)
In-Reply-To: <87d55w5q8s.fsf@semtex.sncag.com> (Rainer Weikusat's message of "Wed, 03 Jan 2007 12:00:51 +0100")
References: <877iw5l2eh.fsf@semtex.sncag.com>
	<20070103013736.GA18198@kroah.com> <87d55w5q8s.fsf@semtex.sncag.com>
From: Rainer Weikusat <rainer.weikusat@sncag.com>
Date: Wed, 03 Jan 2007 15:17:19 +0100
Message-ID: <87irfodwk0.fsf@semtex.sncag.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rainer Weikusat <rw@semtex.sncag.com> writes:

[...]

>> And, we don't want to panic() for such a trivial thing.  Just abort the
>> probe sequence at most, but never shut down the machine for an odd
>> device that we find.
>
> I actually thought about that this morning: Considering the path this
> came from, this is not 'an odd device' but rather something like 'kernel
> memory corruption' (the 'endpoint' value originally came from the
> exact same descriptor).

This turned out to be wrong: The values are hard-coded in keyspan.h.


