Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276361AbRJYVOF>; Thu, 25 Oct 2001 17:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276350AbRJYVNp>; Thu, 25 Oct 2001 17:13:45 -0400
Received: from [194.213.32.137] ([194.213.32.137]:33284 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S276359AbRJYVNi>;
	Thu, 25 Oct 2001 17:13:38 -0400
Date: Thu, 25 Oct 2001 23:59:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rob Turk <r.turk@chello.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5
Message-ID: <20011025235935.B10358@elf.ucw.cz>
In-Reply-To: <20011024130408.23754@smtp.adsl.oleane.com> <Pine.LNX.4.33.0110240901350.8049-100000@penguin.transmeta.com> <9r8icv$ukh$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9r8icv$ukh$1@ncc1701.cistron.net>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The act of "suspend" should basically be: shut off the SCSI controller,
> > screw all devices, reset the bus on resume.
> >
> 
> Doing so will create havoc on sequential devices, such as tape drives. If
> your system simply suspends, then all is well. Any data that isn't flushed
> yet is buffered inside the tapedrive. But when the system resumes and resets
> the SCSI bus, it will cause all data in the tape drive to be lost, and for
> most tape systems it will also re-position them at LBOT. Any running
> tar/dump/whatever tape process would not survive such a suspend-resume
> cycle.

Then there's something wrong with st.

Imagine EMI comes and SCSI gets reset. That should not mean tar
failing, right? So you have st broken in first place.
								Pavel
-- 
STOP THE WAR! Someone killed innocent Americans. That does not give
U.S. right to kill people in Afganistan.


