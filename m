Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbTELW5s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbTELW5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:57:48 -0400
Received: from a.smtp-out.sonic.net ([208.201.224.38]:10886 "HELO
	a.smtp-out.sonic.net") by vger.kernel.org with SMTP id S262902AbTELW5r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:57:47 -0400
X-envelope-info: <dhinds@sonic.net>
Date: Mon, 12 May 2003 16:10:31 -0700
From: David Hinds <dhinds@sonic.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Paul Fulghum <paulkf@microgate.com>, dahinds@users.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: PCMCIA 2.5.X sleeping from illegal context
Message-ID: <20030512161031.B17947@sonic.net>
References: <1052775331.1995.49.camel@diemos> <20030512154416.3f502c36.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512154416.3f502c36.akpm@digeo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 03:44:16PM -0700, Andrew Morton wrote:
> Paul Fulghum <paulkf@microgate.com> wrote:
> >
> > The 2.5.X PCMCIA kernel support seems to have a problem
> > with drivers/pcmcia/rsrc_mgr.c in function undo_irq().
> 
> The timer handlers need to be converted to use schedule_delayed_work(),
> or (more probably) schedule_work().

I don't think the timers need to be scheduled at all; the timer code
should just be executed in-line where the old timers were scheduled.

-- Dave
