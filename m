Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263379AbTDGLZC (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 07:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbTDGLZC (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 07:25:02 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:10695 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S263379AbTDGLZB (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 07:25:01 -0400
Subject: Re: An idea for prefetching swapped memory...
From: Christophe Saout <christophe@saout.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200304072021.17080.kernel@kolivas.org>
References: <200304071026.47557.schlicht@uni-mannheim.de>
	 <200304072021.17080.kernel@kolivas.org>
Content-Type: text/plain
Organization: 
Message-Id: <1049715389.1096.7.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.1.99 (Preview Release)
Date: 07 Apr 2003 13:36:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, 2003-04-07 um 12.21 schrieb Con Kolivas:

> > With this feature there should be no performance decrease because only free
> > resources would be used, and if pages were swapped in but not be used, they
> > stay not dirty and so have not to be written to disk when they are swapped
> > out again. But the improvements should be obvious if simply the last swaped
> > out pages are swapped in again...
> 
> This has been argued before. Why would the last swapped out pages be the best 
> to swap in? The vm subsystem has (somehow) decided they're the least likely 
> to be used again so why swap them in?

Are you sure this is working? When I'm watching a video ofer NFS on my
machine which is idle (just X and mplayer, gnome in background, 256 MB
of memory, 512 swap), after 30 minutes or so, the playback starts to
jump. The cpu usage is below 10%, and it even does this when both X and
mplayer are renice to -19 (!). So the VM swapped everything out and
after 30 minutes it starts to swap out X oder mplayer itself, which is
immediately swapped back in but the video jumps... :-(

-- 
Christophe Saout <christophe@saout.de>

