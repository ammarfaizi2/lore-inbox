Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTJUBMz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 21:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbTJUBMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 21:12:55 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:39096 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262844AbTJUBMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 21:12:53 -0400
Date: Mon, 20 Oct 2003 21:06:10 -0400
From: Ben Collins <bcollins@debian.org>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: marcelo.tosatti@cyclades.com.br, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, James Goodwin <jamesg@filanet.com>
Subject: Re: patch for 2.4.22 sbp2 hang when loaded with devices already connected
Message-ID: <20031021010610.GB866@phunnypharm.org>
References: <ord6csra7h.fsf@free.redhat.lsd.ic.unicamp.br> <orbrsba0eg.fsf@free.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orbrsba0eg.fsf@free.redhat.lsd.ic.unicamp.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 10:40:23PM -0200, Alexandre Oliva wrote:
> We were free()ing a packet before sbp2_agent_reset() had a chance to
> wake up on its semaphore, which would often cause sbp2 to hang in
> `initializing' state if it was loaded when firewire devices were
> already connected to the host.  Details of the symptoms at
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=103821
> 
> This patch fixes it.  I guess Ben likes it because he sent me a very
> similar patch to test just as I was finishing testing this one :-)
> 
> Thanks, Ben, for helping me figure out what was going on!

Please let me send the patch to Marcelo. I have to get this into our
repo, and merge things around back to Marcelo, else it makes things
harder later.

Thanks for following through with the debug to track this down.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
