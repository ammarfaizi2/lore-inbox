Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbTDGMd4 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTDGMd4 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:33:56 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:13769 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S263399AbTDGMdx (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 08:33:53 -0400
Subject: Re: An idea for prefetching swapped memory...
From: Christophe Saout <christophe@saout.de>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030407121918.GA22630@wohnheim.fh-wedel.de>
References: <200304071026.47557.schlicht@uni-mannheim.de>
	 <200304072021.17080.kernel@kolivas.org>
	 <1049715389.1096.7.camel@chtephan.cs.pocnet.net>
	 <yw1xk7e6jzpa.fsf@nogger.e.kth.se>
	 <20030407121918.GA22630@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=iso-8859-15
Organization: 
Message-Id: <1049719521.2596.2.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.1.99 (Preview Release)
Date: 07 Apr 2003 14:45:21 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, 2003-04-07 um 14.19 schrieb Jörn Engel:

> On Mon, 7 April 2003 13:48:17 +0200, Måns Rullgård wrote:
> > Christophe Saout <christophe@saout.de> writes:
> > 
> > > Are you sure this is working? When I'm watching a video ofer NFS on
> > > my machine which is idle (just X and mplayer, gnome in background,
> > > 256 MB of memory, 512 swap), after 30 minutes or so, the playback
> > > starts to jump. The cpu usage is below 10%, and it even does this
> > > when both X and mplayer are renice to -19 (!). So the VM swapped
> > > everything out and after 30 minutes it starts to swap out X oder
> > > mplayer itself, which is immediately swapped back in but the video
> > > jumps... :-(
> > 
> > How much of your memory is in use?  Are you sure there isn't a memory
> > leak somewhere in mplayer?
>
> Anyway, I am quite sure that this is not a kernel problem, so please
> take lkml out of any replies. :)

I'm sorry, I think Måns is right, when the video started to jump,
mplayer took about 60 percent of the memory... in this case I can't
blame the VM. I'm not seeing any reports of memory leaks on its user
list, but my mileage may vary. ;-)

-- 
Christophe Saout <christophe@saout.de>

