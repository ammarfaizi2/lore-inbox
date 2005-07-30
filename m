Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263035AbVG3KIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263035AbVG3KIR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 06:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263030AbVG3KH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 06:07:29 -0400
Received: from imap.gmx.net ([213.165.64.20]:9372 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263008AbVG3KH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 06:07:27 -0400
X-Authenticated: #1725425
Date: Sat, 30 Jul 2005 12:06:45 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-Id: <20050730120645.77a33a34.Ballarin.Marc@gmx.de>
In-Reply-To: <1122678943.9381.44.camel@mindpipe>
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de>
	<1122678943.9381.44.camel@mindpipe>
X-Mailer: Sylpheed version 2.0.0rc (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005 19:15:42 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> 
> What kind of results do you get with a more realistic setup, like
> running KDE or Gnome OOTB?
> 

Here are results with KDE running.

- no peripherals attached, i.e. truly mobile setup.
- all modules loaded
- klaptopdaemon disabled in order to eliminate competition in polling the
  already slow battery controller
- furthermore, I found that artsd prevents entering C3 and generally
  increases power consumption (ALSA, snd_intel8x0)
- voltage is 16.5V

Since the results aren't as stable as in the minimal setup (especially
with HZ=1000), I'll post raw numbers and averages:

HZ=100:                   HZ=1000:      DIFF:

1) averages:

backlight on, artsd off:
765.00                    812.12        42.12

backlight off, arstd off:
637.17                    679.67        42.5

backlight on, artsd on:
927.60                    933.33        5.73

backlight off, artsd on:
799.46                    806.13        6.67

2) raw numbers:

771 mA <= backlight on   801 mA <= backlight on
764 mA                   818 mA
763 mA                   832 mA
763 mA                   817 mA
764 mA                   796 mA
766 mA                   828 mA
764 mA                   831 mA
635 mA <= backlight off  824 mA
635 mA                   795 mA
635 mA                   801 mA
636 mA                   816 mA
636 mA                   797 mA
646 mA                   816 mA
638 mA                   799 mA
637 mA                   817 mA
639 mA                   801 mA
634 mA                   817 mA
637 mA                   668 mA <= backlight off
636 mA                   690 mA
637 mA                   671 mA
764 mA <= backlight on   692 mA
771 mA                   668 mA
929 mA <= artsd started  689 mA
924 mA                   673 mA
942 mA                   711 mA
927 mA                   668 mA
925 mA                   668 mA
926 mA                   689 mA
925 mA                   672 mA
926 mA                   677 mA
923 mA                   672 mA
929 mA                   689 mA
797 mA <= backlight off  672 mA
800 mA                   687 mA
800 mA                   669 mA
813 mA                   687 mA
799 mA                   673 mA
797 mA                   688 mA
798 mA                   668 mA
799 mA                   722 mA <= backlight on
800 mA                   833 mA <= artsd started
797 mA                   929 mA
799 mA                   928 mA
797 mA                   943 mA
797 mA                   929 mA
932 mA <= backlight on   947 mA
                         929 mA
                         929 mA
                         935 mA
                         928 mA
                         945 mA
                         929 mA
                         929 mA
                         809 mA  <= backlight off
                         799 mA
                         814 mA
                         799 mA
                         816 mA
                         799 mA
                         817 mA
                         799 mA
                         805 mA
                         799 mA
                         813 mA
                         800 mA
                         813 mA
                         800 mA
                         817 mA
                         799 mA
                         947 mA <= backlight on
