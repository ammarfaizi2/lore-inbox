Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263385AbTDGLgp (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 07:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbTDGLgp (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 07:36:45 -0400
Received: from elixir.e.kth.se ([130.237.48.5]:8203 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id S263385AbTDGLgo (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 07:36:44 -0400
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: An idea for prefetching swapped memory...
References: <200304071026.47557.schlicht@uni-mannheim.de>
	<200304072021.17080.kernel@kolivas.org>
	<1049715389.1096.7.camel@chtephan.cs.pocnet.net>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 07 Apr 2003 13:48:17 +0200
In-Reply-To: Christophe Saout's message of "07 Apr 2003 13:36:29 +0200"
Message-ID: <yw1xk7e6jzpa.fsf@nogger.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout <christophe@saout.de> writes:

> > > With this feature there should be no performance decrease
> > > because only free resources would be used, and if pages were
> > > swapped in but not be used, they stay not dirty and so have not
> > > to be written to disk when they are swapped out again. But the
> > > improvements should be obvious if simply the last swaped out
> > > pages are swapped in again...
> > 
> > This has been argued before. Why would the last swapped out pages
> > be the best to swap in? The vm subsystem has (somehow) decided
> > they're the least likely to be used again so why swap them in?
> 
> Are you sure this is working? When I'm watching a video ofer NFS on
> my machine which is idle (just X and mplayer, gnome in background,
> 256 MB of memory, 512 swap), after 30 minutes or so, the playback
> starts to jump. The cpu usage is below 10%, and it even does this
> when both X and mplayer are renice to -19 (!). So the VM swapped
> everything out and after 30 minutes it starts to swap out X oder
> mplayer itself, which is immediately swapped back in but the video
> jumps... :-(

How much of your memory is in use?  Are you sure there isn't a memory
leak somewhere in mplayer?

-- 
Måns Rullgård
mru@users.sf.net
