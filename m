Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751738AbWBMKdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbWBMKdA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWBMKdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:33:00 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:26783 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751737AbWBMKc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:32:59 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 11:30:10 +0100
To: schilling@fokus.fraunhofer.de, cfriesen@nortel.com
Cc: tytso@mit.edu, peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F05FB2.nailKUS3MR1N9@burner>
References: <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr>
 <43EB7BBA.nailIFG412CGY@burner>
 <mj+md-20060209.173519.1949.atrey@ucw.cz>
 <43EC71FB.nailISD31LRCB@burner>
 <20060210114721.GB20093@merlin.emma.line.org>
 <43EC887B.nailISDGC9CP5@burner>
 <mj+md-20060210.123726.23341.atrey@ucw.cz>
 <43EC8E18.nailISDJTQDBG@burner>
 <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr>
 <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org>
 <43ECA3FC.nailJGC110XNX@burner> <43ECA70C.8050906@nortel.com>
 <43ECA8BC.nailJHD157VRM@burner> <43ECADA8.9030609@nortel.com>
In-Reply-To: <43ECADA8.9030609@nortel.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Christopher Friesen" <cfriesen@nortel.com> wrote:

> Joerg Schilling wrote:
> > "Christopher Friesen" <cfriesen@nortel.com> wrote:
>
> >>There's nothing there that says the mapping cannot change with 
> >>time...just that it has to be unique.
> > 
> > 
> > If it changes over the runtime of a program, it is not unique from the
> > view of that program.
>
> That depends on what "uniquely identified" actually means.
>
> One possible definition is that at any time, a particular path maps to a 
> single unique st_ino/st_dev tuple.
>
> The other possibility (and this is what you seem to be advocating) is 
> that a st_ino/st_dev tuple always maps to the same file over the entire 
> runtime of the system.

Well it is obvious that this is a requirement.

If Linux does device name mapping at high level but leaves the low level part
unstable, then the following coul happen:

Just think about a program that checks a file that is on a removable media.

This media is mounted via a vold service and someone removes the USB cable
and reinserts it a second later. The filesystem on the device will be mounted
on the same mount point but the device ID inside the system did change.

As a result, the file unique identification st_ino/st_dev is not retained 
and the program is confused.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
