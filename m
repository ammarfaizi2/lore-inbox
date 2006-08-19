Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422777AbWHSUf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422777AbWHSUf7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 16:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422778AbWHSUf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 16:35:59 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:10707 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S1422777AbWHSUf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 16:35:58 -0400
Date: Sat, 19 Aug 2006 22:35:51 +0200
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Bob Reinkemeyer <bigbob73@charter.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [bug] Mouse jumps randomly in x kernel 2.6.18
Message-ID: <20060819203550.GA27549@ojjektum.uhulinux.hu>
References: <44E37FD1.6020506@charter.net> <d120d5000608171138p41b41ce2w38d62117f1817bd0@mail.gmail.com> <44E5283A.8050902@charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E5283A.8050902@charter.net>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 09:38:50PM -0500, Bob Reinkemeyer wrote:
> 
> 
> Dmitry Torokhov wrote:
> >On 8/16/06, Bob Reinkemeyer <bigbob73@charter.net> wrote:
> >>I have an issue where my mouse jumps around the screen randomly in X
> >>only.  It works correctly in a vnc window.  The mouse is a Microsoft
> >>wireless optical intellimouse.  This was tested in 2.6.18-rc1-rc4 and
> >>observed in all. my config for .18 can be found here...
> >>http://rafb.net/paste/results/5cyWFd48.html
> >>
> >>and for .17 here...
> >>http://rafb.net/paste/results/xdFUkU58.html
> >>
> >
> >Does it help if you revert this patch:
> >
> >http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=b0c9ad8e0ff154f8c4730b8c4383f49b846c97c4 
> >
> >
> 
> that fixed it.  Thanks!


Could you try only reverting this part please?

   + param[0] = 200;
   + ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
   + param[0] = 200;
   + ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
   + param[0] = 60;
   + ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);



-- 
pozsy
