Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132162AbRCVT05>; Thu, 22 Mar 2001 14:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132166AbRCVT0r>; Thu, 22 Mar 2001 14:26:47 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:27696 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S132162AbRCVT03>; Thu, 22 Mar 2001 14:26:29 -0500
Date: Thu, 22 Mar 2001 13:24:14 -0600
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Patrick O'Rourke" <orourke@missioncriticallinux.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
Message-ID: <20010322132414.A23177@mandrakesoft.mandrakesoft.com>
In-Reply-To: <3AB9313C.1020909@missioncriticallinux.com> <Pine.LNX.4.21.0103212047590.19934-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.4.21.0103212047590.19934-100000@imladris.rielhome.conectiva>; from Rik van Riel on Wed, Mar 21, 2001 at 08:48:54PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2001 at 08:48:54PM -0300, Rik van Riel wrote:
> On Wed, 21 Mar 2001, Patrick O'Rourke wrote:
> 
> > Since the system will panic if the init process is chosen by
> > the OOM killer, the following patch prevents select_bad_process()
> > from picking init.
> 
> One question ... has the OOM killer ever selected init on
> anybody's system ?

Yes, I managed to reproduce this a while ago.  (init was the only
process around though).

We don't ever kill init, fwiw;  we panic(), which is the right thing
to do if init can't keep running.

> I think that the scoring algorithm should make sure that
> we never pick init, unless the system is screwed so badly
> that init is broken or the only process left ;)

I can't think of a situation where the OOM killer does the wrong thing.
