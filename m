Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286993AbRL1UPA>; Fri, 28 Dec 2001 15:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287000AbRL1UOw>; Fri, 28 Dec 2001 15:14:52 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:47745 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S286993AbRL1UOk>; Fri, 28 Dec 2001 15:14:40 -0500
Message-ID: <3C2CD2A9.6050501@optonline.net>
Date: Fri, 28 Dec 2001 15:14:33 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andris Pavenis <pavenis@latnet.lv>
CC: Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: i810_audio driver version 0.13 still broken
In-Reply-To: <Pine.A41.4.05.10112081022560.23064-100000@ieva06> <200112271110.fBRBA5S00309@hal.astr.lu.lv> <3C2B9649.7090503@optonline.net> <200112280716.fBS7GlE01979@hal.astr.lu.lv>
Content-Type: text/plain; charset=ISO-8859-13; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andris Pavenis wrote:

>Got also my patched 0.12 freezing system later (kernel 2.4.17). Didn't saw
>that earlier with 2.4.17-pre2. Also tried to move port I/O stuff from
>__i810_update_lvi() to start_adc() and start_dac() inside if block to 
>avoid any possibility of doing wait loop when noting is done in start_dac()
>and still get system locking up when loading driver. Perhaps I should
>recheck with kernel 2.4.17-pre2 (I didn't have problems with it before
>leaving to Finland now more than 2 weeks ago)
>
freeze happens on insmod, you mean? or on open("/dev/dsp") or on 
write()? (strace can help check)

>KDE-2.2.2 release (compiled here with gcc-2.95.3)
>
same here, but official kde.org rpm's for redhat (some version of gcc-2.96)

>
>Contents of /proc/pci attached
>
[snip]
only h/w difference visible from my setup from /proc/pci is i have an 
i815 with an Nvidia AGP card and you have an i810 with integrated graphics.

what AC'97 codec is attached to the ICH? (dmesg should say upon driver load)

