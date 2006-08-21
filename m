Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWHUWfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWHUWfl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 18:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWHUWfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 18:35:40 -0400
Received: from mxsf09.cluster1.charter.net ([209.225.28.209]:21993 "EHLO
	mxsf09.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751254AbWHUWfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 18:35:40 -0400
From: Bob Reinkemeyer <bigbob73@charter.net>
To: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [bug] Mouse jumps randomly in x kernel 2.6.18
Date: Mon, 21 Aug 2006 17:35:35 -0500
User-Agent: KMail/1.9.1
References: <44E37FD1.6020506@charter.net> <44E8EED9.9050207@charter.net> <200608202152.04488.dtor@insightbb.com>
In-Reply-To: <200608202152.04488.dtor@insightbb.com>
Cc: pozsy@uhulinux.hu, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608211735.36256.bigbob73@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 August 2006 20:52, you wrote:
> On Sunday 20 August 2006 19:23, Bob Reinkemeyer wrote:
> > just to be clear, is this all you want to revert, or do you want all
> > similar fuctions reverted?
>
> Just the part Poszar quoted - we have a report from another user that
> removing only 2nd part of the explorer 4.0 magic knock cures mouse
> jumpiness.

This worked as well.  Tested in vanilla, a ck based, and an mm based kernel.  
worked well in all.
>
> > Pozsar Balazs wrote:
> > > On Thu, Aug 17, 2006 at 09:38:50PM -0500, Bob Reinkemeyer wrote:
> > >> Dmitry Torokhov wrote:
> > >>> On 8/16/06, Bob Reinkemeyer <bigbob73@charter.net> wrote:
> > >>>> I have an issue where my mouse jumps around the screen randomly in X
> > >>>> only.  It works correctly in a vnc window.  The mouse is a Microsoft
> > >>>> wireless optical intellimouse.  This was tested in 2.6.18-rc1-rc4
> > >>>> and observed in all. my config for .18 can be found here...
> > >>>> http://rafb.net/paste/results/5cyWFd48.html
> > >>>>
> > >>>> and for .17 here...
> > >>>> http://rafb.net/paste/results/xdFUkU58.html
> > >>>
> > >>> Does it help if you revert this patch:
> > >>>
> > >>> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;
> > >>>a=commit;h=b0c9ad8e0ff154f8c4730b8c4383f49b846c97c4
> > >>
> > >> that fixed it.  Thanks!
> > >
> > > Could you try only reverting this part please?
> > >
> > >    + param[0] = 200;
> > >    + ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
> > >    + param[0] = 200;
> > >    + ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
> > >    + param[0] = 60;
> > >    + ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
