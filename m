Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263517AbSJ1SNc>; Mon, 28 Oct 2002 13:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbSJ1SNc>; Mon, 28 Oct 2002 13:13:32 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:4114 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S263517AbSJ1SNb>;
	Mon, 28 Oct 2002 13:13:31 -0500
Date: Mon, 28 Oct 2002 19:18:58 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.44-ac5
Message-ID: <20021028181858.GA1245@mars.ravnborg.org>
Mail-Followup-To: Alan Cox <alan@redhat.com>,
	linux-kernel@vger.kernel.org
References: <200210281452.g9SEqwF17910@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210281452.g9SEqwF17910@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 09:52:58AM -0500, Alan Cox wrote:
> o	Work around makefile breakages for pcmcia scsi	(me)
> 	| Will whoever broke vpath please fix it properly

Being "partner in crime" I would like to give it a try.
Could you give an advice what is the best approach?

What I have thought of so far:
1) Create a small qlogic_fas_stub.c in the pcmia subdirectory that
includes the qlogic_fas.c source in the scsi directory.
2) Do some magic in the makefile so I have a .o file present in
the pcmia sub-directory, build based on the src in the scsi directory.

I never did any of the above because of the following reasons:
a) I have not seen 1) used before, and generally does not like
   including .c files in .c files.
b) Solution 2) looked too ugly to me.
The only difference between the PCMIA version and the normal one is
small details with respect to interrupts.
I wonder if that could be configured during startup of the driver, hereby
selecting between normal or PCMIA version.
But i have never written a Linux driver so my knowledge in this area is
too low to judge.

	Sam

