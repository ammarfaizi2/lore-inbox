Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbUBZPM1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 10:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbUBZPMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 10:12:21 -0500
Received: from netline-mail1.netline.ch ([195.141.226.27]:5641 "EHLO
	netline-mail1.netline.ch") by vger.kernel.org with ESMTP
	id S261989AbUBZPLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 10:11:05 -0500
Subject: Re: [Linux-fbdev-devel] Re: fbdv/fbcon pending problems
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Stuart Young <sgy-lkml@amc.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200402251812.26624.sgy-lkml@amc.com.au>
References: <1077497593.5960.28.camel@gaston>
	 <200402241657.37382.sgy-lkml@amc.com.au>
	 <Pine.GSO.4.58.0402240935390.3187@waterleaf.sonytel.be>
	 <200402251812.26624.sgy-lkml@amc.com.au>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1077808260.2677.98.camel@thor.asgaard.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 26 Feb 2004 16:11:01 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-25 at 08:14, Stuart Young wrote: 
> On Tue, 24 Feb 2004 07:36 pm, Geert Uytterhoeven wrote:
> >
> > There should be an ANSI escape sequence for resetting the scroll region.
> > Just send that to the console.
> 
> Yup there is. It's Esc [r , however this also returns the cursor to the top of 
> the screen. You can use Esc [s & Esc [u to save and restore the current 
> cursor position, so it's just a matter of putting them around it thus:
>  Esc [s Esc [r Esc [u
> 
> Or with echo (in a bash script - \\'s to escape it from the shell):
>  echo -ne \\033[s\\033[r\\033[u
> 
> Now there is a problem with this solution: This leaves the logo (and any 
> boot-time drawn graphics in the unscrollable region) on the screen.

Should it? :)


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer

