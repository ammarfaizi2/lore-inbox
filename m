Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272799AbTHPHPe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 03:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271373AbTHPHPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 03:15:34 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:34059 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S270928AbTHPHPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 03:15:32 -0400
Date: Sat, 16 Aug 2003 09:15:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Douglas Gilbert <dougg@torque.net>
Cc: John Cherry <cherry@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] fix parallel builds for aic7xxx
Message-ID: <20030816071529.GA946@mars.ravnborg.org>
Mail-Followup-To: Douglas Gilbert <dougg@torque.net>,
	John Cherry <cherry@osdl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-scsi@vger.kernel.org
References: <1060906080.4753.92.camel@cherrytest.pdx.osdl.net> <3F3DD0FD.9060705@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3DD0FD.9060705@torque.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 04:36:45PM +1000, Douglas Gilbert wrote:
> While on the subject of aic7xxx Makefiles, they add the
> "-Werror" flag to CFLAGS in both lk 2.4.22-rc2 and
> lk 2.6.0-test3 .
> 
> This flag can be annoying if there is some messiness in
> include files somewhere. In my case some mis-applied patches
> in the ide headers cause otherwise harmless compiler warning.
> That is until my kernel build tries to build the aic7xxx driver.

The incentive for the aic7xx maintainer is that he do detect if a 
warning happens before actually shipping a patch.
Same goes for alpha and sparc64, I recall both David and Richard
wanted to achieve the same goal.

[Wondering if kbuild could do something smart here...]

During the 2.4 series Linus added -Werror to CFLAGS in the top-level
makefile, simply to put more focus on warnings. If was only momentarily
but a lot af patches showed up removing the source of the errors.
The dense output from kbuild these days makes warnings much more
visible, and if you follow John Cherry nice statistics you can see that
the number of warnings generally decrease for each new kernel release.

	Sam
