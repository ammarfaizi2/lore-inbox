Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136400AbRD2WfF>; Sun, 29 Apr 2001 18:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136399AbRD2We6>; Sun, 29 Apr 2001 18:34:58 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:34312 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S136400AbRD2Wen>;
	Sun, 29 Apr 2001 18:34:43 -0400
Date: Sun, 29 Apr 2001 18:35:26 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: John Stoffel <stoffel@casc.com>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.3.1, aka "I stick my neck out a mile..."
Message-ID: <20010429183526.B32748@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	John Stoffel <stoffel@casc.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010427193501.A9805@thyrsus.com> <15084.12152.956561.490805@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15084.12152.956561.490805@gargle.gargle.HOWL>; from stoffel@casc.com on Sun, Apr 29, 2001 at 11:12:56AM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stoffel <stoffel@casc.com>:
> Which is a real PITA because now I have to edit my .config file to
> have:
> 
>    CONFIG_RTC=y

The correct fix for this PITA is for Linus not to ship a broken defconfig.

>               Now when I do a 'make config' it comes up properly.  I
> think this is a poor interface setup.  It should either
> 
> a.  Give more info on what to correct, such as the configuration line
>     to edit and in which file.
> 
> b.  Print a warning, startup the configuration tool and put you at the
>     problematic line, with the help section showing.  Or highlight this
>     choice in some manner as being wrong and showing you how to ffix it.
> 
> This is a minor, but annoying problem and should be fixed ASAP before
> public use.  

I hear you.  The problem is that "what's wrong" is not as well-defined
as one might like.  In this case the error could be in the setting of
X86, SMP, or RTC.  CML2 has no way to know which of these is mis-set, so
it can't know which one to pop up..
 
> At the top-level, most stuff cannot be selected on/off, but you can
> enter it.  But you also do have some y/m/n choices which seems wierd
> and out of place.  For example, "SCSI disk support" is a menu, but
> "HAMRADIO: Amateur Radio support (NEW)" is a y/n choice.  It would
> make more sense to me to have it down a level, with a simple entry to
> "Hamradio support".  Once you go into that level, you would be asked
> to have it turned on/off there.
> 
> This would remove some of the clutter at the top level.  
> 
> As a contrast, the USB entry doesn't ask Y/N for USB support, and when
> I enter the directory, it has all these options listed.  I thought
> that CML would suppres stuff (children, drivers, etc) if I didn't have
> the top level selected.  In this case, I can't turn off USB support in
> any manner, so I see all the children when I could care less about
> them.

USB and SCSI are both enabled/disabled in the system buses menu.  The
apparent confusion 

> Also, the buttons on the right hand side for HELP, are wider when they
> have text in them, but slightly narrower when they are blank.  They
> should be the same width no matter what.  It looks ragged and ugly.

I know.  Sadly, I couldn't find a way to coerce Tcl into doing this right.

> I don't like how it keeps changing the window size whenever you go
> into a sub-level.  It should not re-size the main window at all, it
> should just update the contents and give scroll bars if needed for
> both up/down scolling and side to side.  Once the user has setup their
> prefs, the CML code shouldn't keep it jumping all over the screen.

That's on my to-do list.  It's low-priority, though, since I figure 
most people will use menuconfig.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Today, we need a nation of Minutemen, citizens who are not only prepared to
take arms, but citizens who regard the preservation of freedom as the basic
purpose of their daily life and who are willing to consciously work and
sacrifice for that freedom."
	-- John F. Kennedy
