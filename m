Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWHTXXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWHTXXJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 19:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWHTXXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 19:23:09 -0400
Received: from mxsf25.cluster1.charter.net ([209.225.28.225]:33770 "EHLO
	mxsf25.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932075AbWHTXXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 19:23:08 -0400
Message-ID: <44E8EED9.9050207@charter.net>
Date: Sun, 20 Aug 2006 18:23:05 -0500
From: Bob Reinkemeyer <bigbob73@charter.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060729)
MIME-Version: 1.0
To: Pozsar Balazs <pozsy@uhulinux.hu>
CC: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [bug] Mouse jumps randomly in x kernel 2.6.18
References: <44E37FD1.6020506@charter.net> <d120d5000608171138p41b41ce2w38d62117f1817bd0@mail.gmail.com> <44E5283A.8050902@charter.net> <20060819203550.GA27549@ojjektum.uhulinux.hu>
In-Reply-To: <20060819203550.GA27549@ojjektum.uhulinux.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just to be clear, is this all you want to revert, or do you want all 
similar fuctions reverted?

Bob

Pozsar Balazs wrote:
> On Thu, Aug 17, 2006 at 09:38:50PM -0500, Bob Reinkemeyer wrote:
>>
>> Dmitry Torokhov wrote:
>>> On 8/16/06, Bob Reinkemeyer <bigbob73@charter.net> wrote:
>>>> I have an issue where my mouse jumps around the screen randomly in X
>>>> only.  It works correctly in a vnc window.  The mouse is a Microsoft
>>>> wireless optical intellimouse.  This was tested in 2.6.18-rc1-rc4 and
>>>> observed in all. my config for .18 can be found here...
>>>> http://rafb.net/paste/results/5cyWFd48.html
>>>>
>>>> and for .17 here...
>>>> http://rafb.net/paste/results/xdFUkU58.html
>>>>
>>> Does it help if you revert this patch:
>>>
>>> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=b0c9ad8e0ff154f8c4730b8c4383f49b846c97c4 
>>>
>>>
>> that fixed it.  Thanks!
> 
> 
> Could you try only reverting this part please?
> 
>    + param[0] = 200;
>    + ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
>    + param[0] = 200;
>    + ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
>    + param[0] = 60;
>    + ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
> 
> 
> 
