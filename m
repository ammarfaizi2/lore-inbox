Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288767AbSAQOKb>; Thu, 17 Jan 2002 09:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288768AbSAQOKX>; Thu, 17 Jan 2002 09:10:23 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:5387 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S288767AbSAQOKK> convert rfc822-to-8bit; Thu, 17 Jan 2002 09:10:10 -0500
X-Envelope-From: martin.macok@underground.cz
Date: Thu, 17 Jan 2002 15:10:07 +0100
From: =?iso-8859-2?Q?Martin_Ma=E8ok?= <martin.macok@underground.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: low latency versus sched O(1) - and versus preempt
Message-ID: <20020117151006.A1417@sarah.kolej.mff.cuni.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020111131252.A1366@sarah.kolej.mff.cuni.cz> <20020114010134.D1399@sarah.kolej.mff.cuni.cz> <20020114090644.A1332@sarah.kolej.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020114090644.A1332@sarah.kolej.mff.cuni.cz>; from martin.macok@underground.cz on Mon, Jan 14, 2002 at 09:06:44AM +0100
X-Echelon: GRU NSA GCHQ CIA Pentagon nuclear conspiration war teror anthrax
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shortly: the winner is 2.4.18pre2aa2 for me (but it's close).

> > If I get enough free time, I will test O1+preempt versus O1+mini-ll.
> 
> O1+mini-ll feels better and smoother when playing tuxracer during
> kernel compilation (both nice +19 and +0 cases). (but I haven't tested
> O1+preempt+lockbreak)
> 
> However, comparing full_ll versus O(1)+mini_ll when there's no
> load, I get 10% higher framerate of XMMS/Jess audio/visual plugin.
> When there is some real load, O(1)+mini_ll performs ~30% higher
> framerate then just full_ll.
> 
> (So the winner for my desktop is still vanilla+full_ll+largenice while
> explicitely running non-interactive highload tasks with nice +19 (ie,
> compilations, cronjobs, mailserver...) the only "audio skipping" task
> is mkisofs)

(and if anybody is interested at all)

I have tested many different variants during last week:
/boot/bzImage-2.4.17          /boot/bzImage-2.4.18-pre3-ac1_sh7_ml
/boot/bzImage-2.4.17-rc2      /boot/bzImage-2.4.18-pre3-ac2-sh7-ml
/boot/bzImage-2.4.17sH5       /boot/bzImage-2.4.18-pre3-ac2-sj0-ml
/boot/bzImage-2.4.18pre1      /boot/bzImage-2.4.18-pre3h4p
/boot/bzImage-2.4.18pre2      /boot/bzImage-2.4.18-pre3ll
/boot/bzImage-2.4.18pre2aa2   /boot/bzImage-2.4.18pre3sH4
/boot/bzImage-2.4.18pre2aa2r  /boot/bzImage-2.4.18-pre3sH5
/boot/bzImage-2.4.18pre2l     /boot/bzImage-2.4.18-pre4-si3-ml-p-l
/boot/bzImage-2.4.18pre2s     /boot/bzImage-2.4.9

And as far as I can tell, 2.4.18pre2aa2 is the winner for my desktop.

My usual (and testing workload) consists of KDE2.2.2, Mozilla,
xmms/mp3, mplayer/divx, tuxracer etc.. while 1-2 compilations on
background with nice +19. I experienced most interactive desktop with
-aa kernel.

(My HW is Atlon 850, 256MB RAM, KT133A VIA, Matrox G450).

-- 
         Martin Maèok                 http://underground.cz/
   martin.macok@underground.cz        http://Xtrmntr.org/ORBman/
