Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUEPTjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUEPTjZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 15:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264810AbUEPTjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 15:39:25 -0400
Received: from ms002msg.fastwebnet.it ([213.140.2.52]:17917 "EHLO
	ms002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S264808AbUEPTjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 15:39:23 -0400
Date: Sun, 16 May 2004 21:39:24 +0200
From: Mattia Dongili <dongili@supereva.it>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz, svetljo@gmx.de
Subject: Re: [2.6.5] problems with synaptics/psmouse/atkbd
Message-ID: <20040516193924.GB1976@inferi.kami.home>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, vojtech@suse.cz, svetljo@gmx.de
References: <20040416102903.GA1790@inferi.kami.home> <200404160753.01175.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404160753.01175.dtor_core@ameritech.net>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.5-2 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 07:53:00AM -0500, Dmitry Torokhov wrote:
> On Friday 16 April 2004 05:29 am, Mattia Dongili wrote:
> > [please could you Cc me as I'm not subscribed to linux-kernel]
> > 
> > Hi,
> > 
> > I'm having problems (since 2.6.3 now trying with 2.6.5).
> > Main symptom is that my synaptics touchpad isn't detected after a cold
> > boot. After a warm boot it's detected correctly though.
> 
> Does it help if you load USB modules (*hci-hcd) first and then psmouse?

Hi there, I found the answer to my thread from Svetoslav Slavtchev [1]
(unfortunately he didn't cc-ed me) in the list archives.

His patch solves my problem, any chance to see it included in the
official kernel?
BTW, if more infos on this issue are needed I can easily supply them,
eg:
this is a boot showing the problem:
  Apr 21 15:12:59 inferi kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
  Apr 21 15:12:59 inferi kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
  Apr 21 15:12:59 inferi kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
  Apr 21 15:12:59 inferi kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12

this doesn't:
  Apr 21 15:15:13 inferi kernel: serio: i8042 AUX port at 0x60,0x64 irq 12

thanks

[1]
http://marc.theaimsgroup.com/?l=linux-kernel&m=108213030732425&w=2
-- 
mattia
:wq!
