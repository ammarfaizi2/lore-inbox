Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291269AbSBZQ7V>; Tue, 26 Feb 2002 11:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291314AbSBZQ7L>; Tue, 26 Feb 2002 11:59:11 -0500
Received: from ns.caldera.de ([212.34.180.1]:19356 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S291269AbSBZQ7G>;
	Tue, 26 Feb 2002 11:59:06 -0500
Date: Tue, 26 Feb 2002 17:53:22 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Mike Fedyk <mfedyk@matchmail.com>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the tree
Message-ID: <20020226175322.A31217@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Mike Fedyk <mfedyk@matchmail.com>,
	Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200202260135.18913.Dieter.Nuetzel@hamburg.de> <200202260707.g1Q77CJ02138@ns.caldera.de> <20020226162112.GF4393@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020226162112.GF4393@matchmail.com>; from mfedyk@matchmail.com on Tue, Feb 26, 2002 at 08:21:12AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 08:21:12AM -0800, Mike Fedyk wrote:
> You should talk to Andrew Morton, as he plans to do this also.

Last time I talked to him he was primarily interested in the VM.

> I thought the internals of the scheduler weren't exposed to the rest of the
> kernel...

They shouldn't,  But many old drivers do (and _had to_):

	current->policy = SCHED_YIELD;
	schedule();

which isn't possible with the new scheduler.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
