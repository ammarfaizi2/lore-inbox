Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264898AbUD2Ruk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbUD2Ruk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 13:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264901AbUD2Ruk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 13:50:40 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:6388 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S264898AbUD2Rui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 13:50:38 -0400
Date: Thu, 29 Apr 2004 14:14:13 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429141412.A12541@mail.kroptech.com>
References: <20040428184008.226bd52d.akpm@osdl.org> <Pine.LNX.4.44.0404282147000.19633-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0404282147000.19633-100000@chimarrao.boston.redhat.com>; from riel@redhat.com on Wed, Apr 28, 2004 at 09:47:45PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 09:47:45PM -0400, Rik van Riel wrote:
> On Wed, 28 Apr 2004, Andrew Morton wrote:
> 
> > OK, so it takes four seconds to swap mozilla back in, and you noticed it.
> > 
> > Did you notice that those three kernel builds you just did ran in twenty
> > seconds less time because they had more cache available?  Nope.
> 
> That's exactly why desktops should be optimised to give
> the best performance where the user notices it most...

Agreed. Looking at it from the standpoint of relative change, the time
to bring the mozilla window to the foreground is increased by orders of
magnitude while the kernel builds improve by a (relatively) small
percent. Humans easily notice change in orders of magnitude and such
changes can feel painful. Benchmarks notice $SMALLNUM percent long
before a human will, especially if s/he has left the room because the
job was going to take 10 minutes anyway. The 30 seconds saved off the
compile run just isn't worth it sometimes if its side-effect is to
disrupt the user's workflow.

The 'swappiness' tunable may well give enough control over the situation
to suit all sorts of users. If nothing else, this thread has raised
awareness that such a tunable exists and can be played with to influence
the kernel's decision-making. Distros, too, should give consideration to
appropriate default settings to serve their intended users.

--Adam

