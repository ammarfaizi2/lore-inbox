Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313137AbSDIMFC>; Tue, 9 Apr 2002 08:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313139AbSDIMFB>; Tue, 9 Apr 2002 08:05:01 -0400
Received: from [62.245.135.174] ([62.245.135.174]:32678 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S313137AbSDIMFA>;
	Tue, 9 Apr 2002 08:05:00 -0400
Message-ID: <3CB2D8E6.F0513802@TeraPort.de>
Date: Tue, 09 Apr 2002 14:04:54 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre5-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: m.knoblauch@TeraPort.de,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp fixes] Re: Linux 2.4.19pre5-ac3
In-Reply-To: <3CB1B89D.13DDF456@TeraPort.de> <20020408215908.GI31172@atrey.karlin.mff.cuni.cz> <3CB29AE3.E3447952@TeraPort.de> <20020409105440.GB14695@atrey.karlin.mff.cuni.cz>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/09/2002 02:04:53 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/09/2002 02:04:59 PM,
	Serialize complete at 04/09/2002 02:04:59 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> >
> >  My question was: can I have a system without active swap and still use
> > swsusp? Creating a swap/suspend partition of appropriate size is not a
> > problem. I just do not want to "swapon" it.
> 
> You need to swapon it. If you do not want to keep it swapped on,
> there's no problem in
> 
> swapon /dev/swap
> echo 4 > /proc/acpi/sleep
> sleep 10
> swapoff /dev/swap
> 

 thanks. That is what I wanted to know. That basically means that I will
have to boot with a active swap device in order to get the resume
functionality - correct? And then I would do a "swapoff" late in the
boot process (maybe before starting the graphical crap :-).

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
