Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132615AbRDWKDQ>; Mon, 23 Apr 2001 06:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132724AbRDWKDH>; Mon, 23 Apr 2001 06:03:07 -0400
Received: from mail2.zrz.TU-Berlin.DE ([130.149.4.14]:57570 "EHLO
	mail2.zrz.tu-berlin.de") by vger.kernel.org with ESMTP
	id <S132615AbRDWKC6>; Mon, 23 Apr 2001 06:02:58 -0400
Date: Mon, 23 Apr 2001 12:02:21 +0200
From: Daniel Dorau <woodst@cs.tu-berlin.de>
To: Mick_Tantasirikorn@Dell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Inspiron 8000 does not resume after suspend
Message-ID: <20010423120221.A422@woodstock.home.xxx>
In-Reply-To: <B7D17C5753C8D111AFD200A0C99DAFF405EC01AC@ausxmbrh07.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <B7D17C5753C8D111AFD200A0C99DAFF405EC01AC@ausxmbrh07.aus.amer.dell.com>; from Mick_Tantasirikorn@Dell.com on Sun, Apr 22, 2001 at 09:45:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2001 at 21:45:37 -0500, Mick_Tantasirikorn@Dell.com wrote:
> Try turning off DRI in XF86Config-4.
> 
> Please let me know if this helps.

Yes, removing agpgart gives me back earlier behaviour: The notebook
wakes up after suspending with following restrictions:

1. Internal NIC and maybe even modem do not wakeup
   (kernel: eepro100: wait_for_cmd_done timeout!)
   Can be temporarily fixed by restoring PCI settings with
   setpci ... (script found on linux-kernel in february)
   and ifdown eth0; ifup eth0

2. I can not use DRI since it doesn't wake up then (agpgart loaded)

3. When running X (4.0.2) mouse is jumping around after resume
   and needs to be reset by switching to console and back to X

4. Keyboard repeat-rate is slowed down after resume


Is there a way to have at least 1.+2. fixed? Is this a problem
with Dell's BIOS or Linux?


Thanks,
Daniel

 
> -----Original Message-----
> From: Daniel Dorau [mailto:woodst@cs.tu-berlin.de]
> Sent: Saturday, April 21, 2001 7:52 AM
> To: linux-kernel@vger.kernel.org
> Subject: Inspiron 8000 does not resume after suspend
> 
> 
> Hello,
> my Inspiron 8000 (BIOS A09) notebook running 2.4.3 does not resume 
> after suspending. I have APM compiled in with the following options:
> 
> - Enable PM at boot time
> - Make CPU Idle calls whe ide
> - Enable console blanking using APM
> - RTC stores time in GMT
> 
> Suspending with apm -s seem to work ok - at least it looks like.
> Resuming however, does not work. There is a short disc
> activity, then the harddrive LED is on for about 20 sec without
> any noticable disc activity. Display doesn't switch on,
> NIC (PCI, not PCMCIA) does not wake up (link LED stays off) and the
> whole thing  keeps 'dead'.
> With an older BIOS version that I upgraded because of a newer
> ATI BIOS needed, it woke up execpt some PCI bridge(?) that I 
> could re-activate with a setpci-script that I found in a
> linux-kernel archive. So I think the problem is the same as
> before.
> Is there any way to fix that? I would really like to use
> PM on my notebook.
> 
> Regards, 
> Daniel
> 
> -- 
> Daniel Dorau
> woodst@cs.tu-berlin.de 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
