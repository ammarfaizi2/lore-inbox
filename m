Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTKEFHm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 00:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTKEFHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 00:07:42 -0500
Received: from brains.student.utwente.nl ([130.89.161.140]:47035 "EHLO
	brains.student.utwente.nl") by vger.kernel.org with ESMTP
	id S261500AbTKEFHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 00:07:41 -0500
Message-ID: <3FA885C0.8030906@brains.student.utwente.nl>
Date: Wed, 05 Nov 2003 06:08:16 +0100
From: Justin Ossevoort <justin@brains.student.utwente.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: nforce2 stability on 2.6.0-test5 and 2.6.0-test9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've got an A7N8X mobo, and the same problems. 'noapic' makes the
system run much better. You also have a big interrupt count on int21.
Mine is going beserk. Top shows that almost 30% of my cpu is being
used up on hi (Hardware Interrupts I guess).
Watching /proc/interrupts reveals I get tens of thousands of
interrupts on 21 every second, disabling usb or the soundcard doesn't
help, disabling both does help. Is interrupt 21 doing something funny?

Regards,

        justin....

ross.alexander@uk.neceur.com wrote in message news:<Mh8m.BT.7@gated-at.bofh.it>...
> **** /proc/interrupts ****
> 
>            CPU0 
>   0:   77764351          XT-PIC  timer
>   1:      35127    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   8:          1    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  12:     146812    IO-APIC-edge  i8042
>  14:     105553    IO-APIC-edge  ide0
>  15:       1371    IO-APIC-edge  ide1
>  19:    5329271   IO-APIC-level  nvidia
>  21:   12326898   IO-APIC-level  NVidia nForce2, eth0
> NMI:          0 
> LOC:   77761842 
> ERR:          0
> MIS:          4



