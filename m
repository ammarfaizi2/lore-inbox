Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263337AbTH0KNs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 06:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbTH0KNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 06:13:48 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:27601 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S263337AbTH0KNg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 06:13:36 -0400
Date: Wed, 27 Aug 2003 13:13:13 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org, tejun@aratech.co.kr
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1 solid hangs)
Message-ID: <20030827101313.GX83336@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	linux-kernel@vger.kernel.org, tejun@aratech.co.kr
References: <20030729073948.GD204266@niksula.cs.hut.fi> <20030730071321.GV150921@niksula.cs.hut.fi> <Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva> <20030730181003.GC204962@niksula.cs.hut.fi> <20030827064301.GF150921@niksula.cs.hut.fi> <20030827073758.GW83336@niksula.cs.hut.fi> <20030827113027.64c42485.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030827113027.64c42485.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 11:30:27AM +0200, you [Stephan von Krawczynski] wrote:
> 
> Hm, did you try a serial console? On my side this was a big step forward.

Do you mean in your case nothing shown on monitor (I've disabled monitor
blanking, so that is not it), sysrq key didn't work, nmi watchdog didn't
trigger but you were still able to get output from serial console? An oops?

Or, did you use kdb/kgdb in addition to serial console?

> If you experience complete hangs it may be something around hanging
> interrupts.

Probably, yes.

> Did you play with apic/acpi etc. to try different interrupt handling? 

ACPI has never been enabled. I enabled local APIC when I enabled nmi
watchdog, so I've tried it on and off.

> What does your /proc/interrupts look like compared between 2.2 and 2.4 ?

I don't have 2.2 output at hand, but the 2.4.21-jam1 output doesn't seem too
suspicious:

cat /proc/interrupts 
           CPU0       
  0:    1675428          XT-PIC  timer
  1:          3          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:      19625          XT-PIC  serial
  9:      25447          XT-PIC  aic7xxx
 11:      25203          XT-PIC  eth0
 12:          0          XT-PIC  PS/2 Mouse
 14:     178082          XT-PIC  ide0
NMI:      16763 
LOC:    1675326 
ERR:          0



-- v --

v@iki.fi
