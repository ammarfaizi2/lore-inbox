Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263366AbUFBXhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbUFBXhy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 19:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265377AbUFBXhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 19:37:53 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:23937 "EHLO cloud.ucw.cz")
	by vger.kernel.org with ESMTP id S263366AbUFBXhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 19:37:51 -0400
Date: Thu, 3 Jun 2004 01:39:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Erik Steffl <steffl@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
Message-ID: <20040602233918.GA1366@ucw.cz>
References: <40853060.2060508@bigfoot.com> <200404280741.08665.dtor_core@ameritech.net> <408FFC2A.3080504@bigfoot.com> <200404281824.05044.dtor_core@ameritech.net> <4090A1FA.1070202@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4090A1FA.1070202@bigfoot.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 11:34:34PM -0700, Erik Steffl wrote:
> Dmitry Torokhov wrote:
> >On Wednesday 28 April 2004 01:47 pm, Erik Steffl wrote:
> >>Dmitry Torokhov wrote:
> >>
> >>>What protocol are you using in XFree?
> >>
> >>  that's irrelevant, I got the results above without X running (by 
> >
> >No, it is not. Please change protocol in XF86Config to ExplorerPS/2.
> ...
> >Kernel only provides emulation of 3 protocols via /dev/psaux: bare PS/2,
> >IntelliMouse PS/2 and Explorer PS/2. Since your program does not issue
> >Intellimouse or Explorer protocol initialization sequences it gets just
> >bare PS/2 protocol data - 2 axis, 3 buttons. Extra buttons are mapped onto
> >first 3. For exact mapping consult drivers/input/mousedev.c
> 
>   thanks, that makes sense, I tried ExplorerPS/2, it works better, the 
> wheel works but side button is still same as button 2.
> 
>   would it be different if I used /dev/input/mouse0? or 
> /dev/input/mice?  kernel Documentation/input/input.txt seems to be 
> fairly old (mentions  2.5/2.6 in future tense) and it says to use 
> "ExplorerPS/2 if you want to use extra (up to 5) buttons" when 
> discussing what /dev/input/mouse0 provides. Does that mean that there's 
> no way to use extra side button (which is the sixth button)?

Yes, at this time you can't use the sixth button in X with a 2.6 kernel.
An event driver for X would be needed instead of the ExplorerPS/2 one.

-- 
