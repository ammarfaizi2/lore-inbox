Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132762AbRDQRG5>; Tue, 17 Apr 2001 13:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132774AbRDQRGt>; Tue, 17 Apr 2001 13:06:49 -0400
Received: from ulima.unil.ch ([130.223.144.143]:64016 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S132773AbRDQRGX>;
	Tue, 17 Apr 2001 13:06:23 -0400
Date: Tue, 17 Apr 2001 19:06:20 +0200
From: FAVRE Gregoire <greg@ulima.unil.ch>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB with 2.4.3-ac{1,3,7} without devfs-> aic7xxx ?
Message-ID: <20010417190620.B31178@ulima.unil.ch>
Mail-Followup-To: FAVRE Gregoire <greg@ulima.unil.ch>,
	Johannes Erdfelt <johannes@erdfelt.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010417004248.A19914@ulima.unil.ch> <20010416185740.Y4295@sventech.com> <20010417182130.A30800@ulima.unil.ch> <20010417123546.B4295@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010417123546.B4295@sventech.com>; from johannes@erdfelt.com on Tue, Apr 17, 2001 at 12:35:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Johannes Erdfelt (johannes@erdfelt.com):

> http://www.linux-usb.org

Thanks, I'll go there ;-)

> > Sorry for the strange looking of my copy and paste to vim...
> 
> You may want to turn off auto-indent under vim, or you can always just
> remove the excess spaces by hand.

Thanks also for that answer, here are the one I got from several people:
---------------------------------------------------------------------
^o:set paste
[paste stuff]
^o:set nopaste

Or you could ^[ back to cmd mode first..  I find ^o more useful for a
quick set change like that though.
---------------------------------------------------------------------
Hint: use shift+v to mark the lines, then gc to format the text.
---------------------------------------------------------------------
Hint: type ':set paste' before pasting and ':set nopaste' after pasting.

> Nope. Both drivers support IRQ sharing just fine.

Yes, at most under 2.4.3 ;-)

> > So, as my only change in config betweem 2.4.3 and 2.4.3-ac[137] was the
> > removing of devfs, that's not the problem...
 
> Yeah. I don't think there are any changes in the USB code between 2.4.3
> and 2.4.3-ac[137].
> 
> I'll have to check and see.

Well, I think there are some change in usb:
[greg@localhost kernel]$ foreach x ( patch-2.4.3-ac*-ac* )
foreach? echo $x
foreach? bzcat $x |grep -i usb|wc -l
foreach? end
patch-2.4.3-ac1-ac2.bz2
    132
patch-2.4.3-ac2-ac3.bz2
      6
patch-2.4.3-ac3-ac4.bz2
     12
patch-2.4.3-ac4-ac5.bz2
    160
patch-2.4.3-ac5-ac6.bz2
      0
patch-2.4.3-ac6-ac7.bz2
     14

(Notice the good paste)

None of those seems to change things in usb-uhci

Thanks for all your help (and all the answer concerning vim, I haven't
yet replyed to two, because they are PGP signed and I still have problem
with PGP with mutt...), it's time for http://www.linux-usb.org ;-))

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
