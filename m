Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290386AbSBFLCc>; Wed, 6 Feb 2002 06:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290417AbSBFLCW>; Wed, 6 Feb 2002 06:02:22 -0500
Received: from mx2.elte.hu ([157.181.151.9]:49593 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290386AbSBFLCO>;
	Wed, 6 Feb 2002 06:02:14 -0500
Date: Wed, 6 Feb 2002 14:00:02 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Kristian <kristian.peters@korseby.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: New scheduler in 2.4. series?
In-Reply-To: <20020206090831.2dce8469.kristian.peters@korseby.net>
Message-ID: <Pine.LNX.4.33.0202061358460.5667-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 6 Feb 2002, Kristian wrote:

> -K2 behaves much better as -J2 did. The system gets continuously
> responsive again. But with nicelevel -5 at the beginning of each 'tar`
> the systems stalls for 2 or 3 seconds.

yes, it takes 2-3 seconds for the system to notice that the 'tar' process
started from your interactive shell is in fact a 'CPU hog'. The system was
honoring root's request for CPU time.

this should not happen if you start it at nice -2, which should still give
'tar' enough of an advantage.

	Ingo

