Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbTBCKQf>; Mon, 3 Feb 2003 05:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265305AbTBCKQf>; Mon, 3 Feb 2003 05:16:35 -0500
Received: from mail.ithnet.com ([217.64.64.8]:40202 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S265285AbTBCKQe>;
	Mon, 3 Feb 2003 05:16:34 -0500
Date: Mon, 3 Feb 2003 11:25:48 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: 2.4.21-pre4: tg3 driver problems with shared interrupts
Message-Id: <20030203112548.357c2bb9.skraw@ithnet.com>
In-Reply-To: <3E3D6367.9090907@pobox.com>
References: <20030202161837.010bed14.skraw@ithnet.com>
	<3E3D4C08.2030300@pobox.com>
	<20030202185205.261a45ce.skraw@ithnet.com>
	<3E3D6367.9090907@pobox.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Feb 2003 13:28:55 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> > To make sure I will let it stress-test overnight and send you the results
> > in about 15 hours from now on. If everything does fine I will redo with
> > ide2,ide3 on same interrupt, too. Just to see what happens with these
> > Promise things...

Hi Jeff,

I can tell you for sure now that your tg3 driver does very well in shared
interrupt config:
(eth2 is tg3)

           CPU0       
  0:    6052783          XT-PIC  timer
  1:       8618          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:        581          XT-PIC  EMU10K1
  7:       6842          XT-PIC  HiSax
  9:   30245790          XT-PIC  aic7xxx, aic7xxx, eth0, eth1, eth2
 11:    7324397          XT-PIC  ide2, ide3
 12:     196375          XT-PIC  PS/2 Mouse
 15:          2          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:         52
MIS:          0


Though I don't exactly know what "ERR:" means in this context the machine is
alive and performing well.
Now I go again for the Promise stuff ...

-- 
Regards,
Stephan
