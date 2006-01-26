Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWAZQKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWAZQKI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 11:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbWAZQKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 11:10:07 -0500
Received: from styx.suse.cz ([82.119.242.94]:56193 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S964772AbWAZQKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 11:10:06 -0500
Date: Thu, 26 Jan 2006 17:10:28 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060126161028.GA8099@suse.cz>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D8C04F.nailE1C2X9KNC@burner>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 01:27:59PM +0100, Joerg Schilling wrote:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> > Joerg Schilling schrieb am 2006-01-25:
> >
> > > > You are perfectly free to adjust your compatibility layer accordingly.
> > > 
> > > The Linux Kernel fols unfortunately artificially hides information for the 
> > > /dev/hd* interface making exactly this compatibility impossible.
> >
> > What information is actually missing? You keep talking about phantoms,
> > without naming them. Again: device enumeration doesn't count, libscg
> > already does that.
> 
> I am not talking about phantoms, I am always requestung the same things.
> It only seems that people here ignore these issues.
> 
> The only integrative (and this useful for libscg) interface on Linux is /dev/sg*
> 
> /dev/hd* may look nice if you only look skin-deep
> 
> How do you e.g. like send SCSI commands to ATAPI tape drives on Linux?
 
I see you asking this again and again, and you seem to want to hear this
answer: "You don't." I haven't checked the code, but I guess the SG_IO
interface isn't available there. And I don't think this is a problem,
because a) if it was needed, it can be added trivially with minimum
added code, b) ATAPI tapes are dead, much the way ATAPI floppies are.

So can you now stop repeating this question, please?

It has no relevance to CD burning. 

I admit I can see the elegance in your /dev/scg solution on Solaris, but
you should accept that you're not going to get anything like that on
Linux, because it simply doesn't fit in the Linux frame of doing things.

In Linux we have devices and operate on them. They can be hotplugged and
assigned stable names via udev. A tunnel into the transport layer, like
your /dev/scg on Solaris, simply doesn't have place in Linux.

I believe that if you added Linux 2.6 support code in libscg/cdrecord,
that'd simply accept the device name as an argument and didn't use *any*
scanning code at all, you'd make a lot of people happy (*). Quite possibly
everyone minus one man. Which would be a great achievement.


(*) It'd be impossible to burn CDs in a tape drive on Linux then, but,
    I don't think that'll cause a lot of grief.
-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
