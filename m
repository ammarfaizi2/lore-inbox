Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265855AbUAFFHN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 00:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbUAFFHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 00:07:13 -0500
Received: from audible.transient.net ([66.93.40.125]:37903 "HELO
	audible.transient.net") by vger.kernel.org with SMTP
	id S265855AbUAFFHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 00:07:10 -0500
Date: Mon, 5 Jan 2004 20:57:45 -0800
From: Jamie Heilman <jamie@audible.transient.net>
To: linux-kernel@vger.kernel.org
Cc: Jakub Bogusz <qboosh@pld-linux.org>
Subject: Re: [PATCH 2.6][RESEND] fix for oopses in some OSS drivers
Message-ID: <20040106045745.GG13581@audible.transient.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jakub Bogusz <qboosh@pld-linux.org>
References: <20040105222940.GC1555@satan.blackhosts> <20040105201751.428aa871.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105201751.428aa871.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jakub Bogusz <qboosh@pld-linux.org> wrote:
> >
> > The patch was made against 2.6.0-test11, but I checked 2.6.1-rc1-bk and
> >  2.6.1-rc1-mm2 - they're still not fixed.
> 
> Patch seem fine, thanks.
> 
> >  Or should I just click-click this into bugzilla and wait?
> 
> bugzilla is a bit of a black hole, sorry.  Sending (and resending) to the
> mailing list is appropriate.

Hmm, in that case, can we add to that patch the use-after-free
oops fix for the MultiSound OSS driver too?  Its a one-liner:
just remove __init from the msnd_register() declaration on line 60 of
sound/oss/msnd.c

its #1709 in bugzilla

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/
"You came all this way, without saying squat, and now you're trying
 to tell me a '56 Chevy can beat a '47 Buick in a dead quarter mile?
 I liked you better when you weren't saying squat kid." -Buddy
