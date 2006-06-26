Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWFZO6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWFZO6u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWFZO6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:58:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:48026 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932376AbWFZO6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:58:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HdbG+jQM+khjOPQ8q0FeO0fh2oY6ci9Er0HGhKpVqy+NdjjCLXeM1TLTzjWTknfFLQb4zRfffAWdoay4DXnDJEPIsB5cOCtjr7l+t7ql8jaiCwiqJ9YV8NUQutWaJi22bfyU79dYg1Rdx0TBeO959V4OVAf2Izo12JzlS4IicB0=
Message-ID: <d120d5000606260758m2ee97482m517d432f88975d87@mail.gmail.com>
Date: Mon, 26 Jun 2006 10:58:46 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: [PATCH] atkbd: restore autorepeat rate after resume
Cc: "Alan Stern" <stern@rowland.harvard.edu>, "Andrew Morton" <akpm@osdl.org>,
       "Kernel development list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060626145332.GB24275@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.44L0.0606261017340.9467-100000@iolanthe.rowland.org>
	 <d120d5000606260735v6e1762d7mc278f315c3a994fb@mail.gmail.com>
	 <20060626145332.GB24275@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Mon, Jun 26, 2006 at 10:35:44AM -0400, Dmitry Torokhov wrote:
> > On 6/26/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> > >From: Linus Torvalds <torvalds@osdl.org>
> > >
> > >This patch (as728) makes the AT keyboard driver store the current
> > >autorepeat rate so that it can be restored properly following a
> > >suspend/resume cycle.
> > >
> >
> > Alan,
> >
> > I think it should be a per-device, not global parameter. Anyway, I'll
> > adjust adn apply, thank you.
>
> You can't make it per-device when there is no device when the keyboard
> isn't plugged in. ;)
>

It there is no keyboard then you could not change repeat rate before
suspending and we don't have anyhting to restore ;)

-- 
Dmitry
