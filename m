Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTDGMIT (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTDGMIT (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:08:19 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:29104 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263380AbTDGMIS (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 08:08:18 -0400
Date: Mon, 7 Apr 2003 14:19:19 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: Christophe Saout <christophe@saout.de>, linux-kernel@vger.kernel.org
Subject: Re: An idea for prefetching swapped memory...
Message-ID: <20030407121918.GA22630@wohnheim.fh-wedel.de>
References: <200304071026.47557.schlicht@uni-mannheim.de> <200304072021.17080.kernel@kolivas.org> <1049715389.1096.7.camel@chtephan.cs.pocnet.net> <yw1xk7e6jzpa.fsf@nogger.e.kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xk7e6jzpa.fsf@nogger.e.kth.se>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 April 2003 13:48:17 +0200, Måns Rullgård wrote:
> Christophe Saout <christophe@saout.de> writes:
> 
> > Are you sure this is working? When I'm watching a video ofer NFS on
> > my machine which is idle (just X and mplayer, gnome in background,
> > 256 MB of memory, 512 swap), after 30 minutes or so, the playback
> > starts to jump. The cpu usage is below 10%, and it even does this
> > when both X and mplayer are renice to -19 (!). So the VM swapped
> > everything out and after 30 minutes it starts to swap out X oder
> > mplayer itself, which is immediately swapped back in but the video
> > jumps... :-(
> 
> How much of your memory is in use?  Are you sure there isn't a memory
> leak somewhere in mplayer?

s/mplayer/X11/

The behaviour on my noteboot (512MB, no swap) is that X keeps grabbing
more memory until either I or OOM take measures.
The interesting part about it is that Mozilla and gcfclient seem to
cause the memory leak - X frees up to 400MB when one of those is
closed - but according to top, X owns that memory.

Anyway, I am quite sure that this is not a kernel problem, so please
take lkml out of any replies. :)

Jörn

-- 
"Translations are and will always be problematic. They inflict violence 
upon two languages." (translation from German)
