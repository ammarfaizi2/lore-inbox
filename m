Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132168AbRCVTah>; Thu, 22 Mar 2001 14:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132167AbRCVTa1>; Thu, 22 Mar 2001 14:30:27 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:13621 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S132165AbRCVTaP>; Thu, 22 Mar 2001 14:30:15 -0500
Date: Thu, 22 Mar 2001 13:29:02 -0600
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
Message-ID: <20010322132902.B23177@mandrakesoft.mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.21.0103212047590.19934-100000@imladris.rielhome.conectiva> <m18zly2pam.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <m18zly2pam.fsf@frodo.biederman.org>; from Eric W. Biederman on Thu, Mar 22, 2001 at 01:14:41AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2001 at 01:14:41AM -0700, Eric W. Biederman wrote:
> Rik van Riel <riel@conectiva.com.br> writes:
> Is there ever a case where killing init is the right thing to do?

There are cases where panic() is the right thing to do.  Broken init
is such a case.

> My impression is that if init is selected the whole machine dies.
> If you can kill init and still have a machine that mostly works,

you can't.

> Guaranteeing not to select init can buy you piece of mind because
> init if properly setup can put the machine back together again, while
> not special casing init means something weird might happen and init
> would be selected.

If we're in a situation where long-running processes with relatively
small VM are killed the box is very unlikely to be usable anyway.
