Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261703AbSJFQhA>; Sun, 6 Oct 2002 12:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261707AbSJFQhA>; Sun, 6 Oct 2002 12:37:00 -0400
Received: from bohnice.netroute.lam.cz ([212.71.169.62]:24049 "EHLO
	vagabond.cybernet.cz") by vger.kernel.org with ESMTP
	id <S261703AbSJFQg7>; Sun, 6 Oct 2002 12:36:59 -0400
Date: Sun, 6 Oct 2002 18:42:28 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Cc: jw schultz <jw@pegasys.ws>
Subject: Re: Unable to kill processes in D-state
Message-ID: <20021006164228.GB17170@vagabond>
Reply-To: Jan Hudec <bulb@vagabond.cybernet.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org,
	jw schultz <jw@pegasys.ws>
References: <20021005090705.GA18475@stud.ntnu.no> <1033841462.1247.3716.camel@phantasy> <20021005182740.GC16200@vagabond> <20021005235614.GC25827@stud.ntnu.no> <20021006021802.GA31878@pegasys.ws> <1033871869.1247.4397.camel@phantasy> <20021006024902.GB31878@pegasys.ws> <20021006105917.GB13046@stud.ntnu.no> <20021006122415.GE31878@pegasys.ws> <20021006143636.GA30441@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021006143636.GA30441@stud.ntnu.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 04:36:36PM +0200, Thomas Lang?s wrote:
> jw schultz:
> > Are all those processes hanging because of NFS?  If so, i'd
> > start by looking at the mount options as i said before.  I'd
> > also look into the network and fileserver because something
> > is wrong.  In my experience Solaris behaved the same way.
> 
> They're hanging because I killed of the autofs-processes, and
> started it again. (And then every NFS-share is remounted).
> So, basically, they're all hanging there, and will keep 
> hanging there 'till I boot the machine. 

If the shares were successfuly reloaded, then the processes should wake
up. If they don't, it's a bug in NFS.

Try to reproduce it (ie. reboot some machine, let it start everything
and then restart the autofsd and see if processes lock up) and then talk
to NFS maintainers about that.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
