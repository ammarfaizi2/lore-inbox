Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbUK0ERx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbUK0ERx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbUK0D7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:59:18 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:4767 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262351AbUKZTaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:30:46 -0500
Subject: Re: Suspend 2 merge: 10/51: Exports for suspend built as modules.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125180725.GB1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101294252.5805.228.camel@desktop.cunninghams>
	 <20041125180725.GB1417@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1101418822.27250.26.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 08:40:22 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 05:07, Pavel Machek wrote:
> Hi!
> 
> > The sys_ functions are exported because a while ago, people suggested I
> > use /dev/console to output text that doesn't need to be logged, and I
> > also use /dev/splash for the bootsplash support. These functions were
> 
> Well, we don't do ascii-art on kernel boot and I do not see why we should do it
> on suspend. Distributions will love bootsplash integration, but it should stay as a separate
> patch.

It's modular, so no problem there.

> See swsusp1... it has percentage printing, and I think it should
> be possible to make it look good enough.

We can always make a tex_ mode_for_Pavel plugin :>
	
> Why do you need sys_mkdir?

The text mode plugin is using it to make /dev (if it doesn't exist) so
it can try to mount devfs (if necessary) and open /dev/console to do the
output. I'd love to just use vt_console_print, but those who know better
then me said to use /dev/console...

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

