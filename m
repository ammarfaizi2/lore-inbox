Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbUDPNfe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 09:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263168AbUDPNfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 09:35:34 -0400
Received: from mid-1.inet.it ([213.92.5.18]:62438 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S263162AbUDPNf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 09:35:28 -0400
Date: Fri, 16 Apr 2004 15:35:20 +0200
From: Mattia Dongili <dongili@supereva.it>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [2.6.5] problems with synaptics/psmouse/atkbd
Message-ID: <20040416133520.GB1790@inferi.kami.home>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, vojtech@suse.cz
References: <20040416102903.GA1790@inferi.kami.home> <200404160753.01175.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404160753.01175.dtor_core@ameritech.net>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.5-1 i686
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

no, it's already that way (I changed the modules loading order at 2.6.1
time when the synaptics mouse was being stolen by usb[1]):
# cat /etc/modules
uhci-hcd
hid
agpgart
intel-agp
radeon
pcspkr
evdev
speedstep-ich
sonypi
#parport_pc
#lp
psmouse

Also, I cannot disable USB Legacy support from bios.

I'm using a sony vaio gr7/k - same chipset as
PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP:
# lspci | grep -i usb
0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 01)
0000:00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 01)
0000:00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 01)

the really weird things are the *This is an XFree86 bug* messages, when
xfree isn't even running. Any idea? more debug printks I might add?

thanks (please still Cc me)

[1]: http://marc.theaimsgroup.com/?l=linux-kernel&m=107512283220051&w=2
-- 
mattia
:wq!
Hodie decimo sexto Kalendas Maias MMDCCLVII ab urbe condita est
