Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288971AbSANTNy>; Mon, 14 Jan 2002 14:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288967AbSANTMg>; Mon, 14 Jan 2002 14:12:36 -0500
Received: from web20910.mail.yahoo.com ([216.136.226.232]:7441 "HELO
	web20910.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S288959AbSANTL0>; Mon, 14 Jan 2002 14:11:26 -0500
Message-ID: <20020114191125.90455.qmail@web20910.mail.yahoo.com>
Date: Mon, 14 Jan 2002 11:11:25 -0800 (PST)
From: Paul Lorenz <p1orenz@yahoo.com>
Subject: Re: Driver via ac97 sound problem (VT82C686B)
To: Jeremy Lumbroso <j.lumbroso@noos.fr>, salvador@inti.gov.ar
Cc: Raul Sanchez Sanchez <raul@dif.um.es>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also tried and neither worked for me, though I
appreciate the effort :)

I did get a couple of other messages, if this helps: 

Assertion failed! chan->is_active ==
sg(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1198

(typed by hand as I'm on another computer)

I got that using the eapd_init2_ops.

Note: the patch was missing prototypes for
eapd_on_control and eapd_off_control. Also my 
sound chip is 0x41445361 not 0x41445461, so 
I added that entry.

Paul

--- Jeremy Lumbroso <j.lumbroso@noos.fr> wrote:
> hi 
> i apply the patch and compile with the two values
> but i still heard no sound .
> Did someone got this driver works ?
> thx 
> 
> 
> Le Lundi 14 Janvier 2002 18:13, salvador a écrit :
> > As Alan says: "The VIA driver doesnt appear to
> support the ac97 ops."
> > Here I'm attaching a brut force test, I created a
> small function that turns
> > ON the EAPD and another to turn it OFF. Note that
> according to dataseets a
> > 1 will disable the external amplifier, but you
> should try with the two
> > values. I attached the modified code. It have a
> 1886 entry that will
> > initialize the codec setting EAPD output to 0. The
> code have a commented
> > entry that does the reverse, try both.
> > I also attached the diffs so Alan can check if
> that could work.
> > Note: I didn't compile it so watch for typos ;-)
> >
> > SET
> 
> -- 
> __________________________
> Lumbroso Jeremy
> 188 bd malesherbes 
> 75017 PARIS
> 01,47,64,07,94
> 06,19,77,01,25
> __________________________


__________________________________________________
Do You Yahoo!?
Send FREE video emails in Yahoo! Mail!
http://promo.yahoo.com/videomail/
