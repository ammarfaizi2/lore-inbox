Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbUACVA3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 16:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbUACVA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 16:00:28 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:3518
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263946AbUACVAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 16:00:23 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Soeren Sonnenburg <kernel@nn7.de>, Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
Date: Sun, 4 Jan 2004 08:00:06 +1100
User-Agent: KMail/1.5.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <1073161172.9851.260.camel@localhost>
In-Reply-To: <1073161172.9851.260.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401040800.06529.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jan 2004 07:19, Soeren Sonnenburg wrote:
> On Sat, 2004-01-03 at 20:40, Mark Hahn wrote:
> > > yeah, I think so... but as generating output in a shell is a very
> > > common thing to do there should either be an option to turn that
> > > unwanted behaviour off or to fix this issue...
> >
> > has anyone said it's desired behavior?  you probably need to describe
> > your setup more.  for instance, is your X niced to negative?  are there
> > some background processes which would be consuming cycles?
>
> freshly booted system with X running at niceness 0 no other processes
> consume cpu cycles.
>
> it is reproducable by creating any kind of output which reads from disk...
> so i.e. a find ./ in my home directory takes sometimes like 30 minutes on
> 2.6 (100%cpu load) and sometimes 5 minutes (on 2.4 always 5 minutes
> ~40%load).
>
> dmesg is another candidate... just doing cat <file> seems not to trigger
> that problem.
>
> As Willy Tarreau also oberves this very same weirdness - I now know the
> problem is there and it is not specific to my setup.

There is a BASH bug that Linus noticed brought out by the more sensitive 
timing in 2.6. The BASH developer has been informed it is there and it is 
fixed in the latest version. Perhaps you're both seeing that. Check the lkml 
archives.

Con

