Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbVA0RtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbVA0RtH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbVA0Rs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:48:58 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:15375 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S262670AbVA0RpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:45:11 -0500
Date: Thu, 27 Jan 2005 18:45:06 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Andries Brouwer <aebr@win.tue.nl>,
       dtor_core@ameritech.net, linux-input@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: i8042 access timings
Message-ID: <20050127174506.GB6010@pclin040.win.tue.nl>
References: <200501250241.14695.dtor_core@ameritech.net> <20050125105139.GA3494@pclin040.win.tue.nl> <d120d5000501251117120a738a@mail.gmail.com> <20050125194647.GB3494@pclin040.win.tue.nl> <1106685456.10845.40.camel@krustophenia.net> <1106838875.14782.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106838875.14782.20.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: MessageCare: pastinakel.tue.nl 1108; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Discussion:

Dmitry:
Here are patches with some delays. One never knows - maybe they
help someone.

Andries:
Only insert delays in the kernel source when either we know about
at least one person who reports that it helps, or about data sheets
that specify that the delay is required. Otherwise one creates
myths and superstition.

Lee Revell:
> > Seems like a comment along the lines of "foo hardware doesn't work right
> > unless we delay a bit here" is the obvious solution.  Then someone can
> > easily disprove it later.

At present the comment would be
"Here is a delay - nobody knows why we are adding it".

Alan:
> Myths are not really involved here. The IBM PC hardware specifications
> are fairly well defined

If there is a data sheet that requires the delay I am of course happy.
If there are test results that show that it helps, I am happy as well.
But the given motivation was "you never know - it might help". Bad.

The present situation is that often 2.4 works and 2.6 fails.
Not because of some delay that is also absent in 2.4.
Often because of all those keyboard commands we send to the hardware.
Sometimes also because of ACPI.

Andries
