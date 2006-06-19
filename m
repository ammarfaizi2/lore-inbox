Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWFSChD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWFSChD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 22:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWFSChC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 22:37:02 -0400
Received: from mf2.realtek.com.tw ([60.248.182.46]:15110 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S1751031AbWFSChA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 22:37:00 -0400
Message-ID: <006f01c69349$394a8ac0$106215ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: "Mike Smullin" <mikesmullin@s161200816.onlinehome.us>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: <linux-kernel@vger.kernel.org>
References: <d5a2d4790606160939i50ca65dfn2a4d92bc9b4a0fb0@mail.gmail.com>
Subject: Re: Solve the problem that umount will fail when an opened file isn't closed
Date: Mon, 19 Jun 2006 10:36:52 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/06/19 =?Bog5?B?pFekyCAxMDozNjo1Mg==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/06/19 =?Bog5?B?pFekyCAxMDozNjo1NQ==?=,
	Serialize complete at 2006/06/19 =?Bog5?B?pFekyCAxMDozNjo1NQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mike,
Do you want to see the hotplug agent code?
I can mail it to you and I would be very grateful if you can give me any
suggestion to improve it.
It will be used on a consumer product and would be better to be very stable.

Regards,
Colin


----- Original Message ----- 
From: "Mike Smullin" <mikesmullin@s161200816.onlinehome.us>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>; "colin"
<colin@realtek.com.tw>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, June 17, 2006 12:39 AM
Subject: Re: Solve the problem that umount will fail when an opened file
isn't closed


> Thanks for that, Jan. What a great idea!
>
> > >I have implemented an auto-mount & auto-umount
> > facility based on USB
> > >hotplug.
>
> Colin can you explain how you implemented this? I would like to try it,
too.
>
> Thanks,
> Mike
>
> --
> Mike Smullin
> "The day I come in front of the Gartner audience and say we have a
> better Unix than Linux, that'll be a good day" -- Steve Ballmer
> http://www.mikesmullin.com
>
> --- Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> > >
> > >Hi all,
> > >I have implemented an auto-mount & auto-umount
> > facility based on USB
> > >hotplug.
> > >An annoying problem will occur when some process
> > doesn't close its open file
> > >and auto-umount is trying to umount that mount
> > point after usb disk has been
> > >unplugged.
> > >Is there any way to force it to be umounted in this
> > situation?
> > >
> >
> > fs/super.c:
> >
> >     /* Forget any remaining inodes */
> >     if (invalidate_inodes(sb)) {
> >         printk("VFS: Busy inodes after unmount of
> > %s. "
> >            "Self-destruct in 5 seconds.  Have a nice
> > day...\n",
> >            sb->s_id);
> >     }
> >
> > That's what happens if you eject a CD. The box won't
> > explode though.
> >
> >
> > Jan Engelhardt
> > --
> > -
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >

