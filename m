Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267063AbTGTNBX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 09:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267064AbTGTNBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 09:01:23 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:51172 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S267063AbTGTNAv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 09:00:51 -0400
Message-ID: <3F1A969C.6060606@free.fr>
Date: Sun, 20 Jul 2003 15:18:20 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       sziwan@hell.org.pl
Subject: Re: Linux 2.6-pre1 Does not boot on ASUS L3800C: lock up in acpi
 while  "Executing all Devices _STA and_INIT methods"
References: <F760B14C9561B941B89469F59BA3A847E9702C@orsmsx401.jf.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E9702C@orsmsx401.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:
>>From: Eric Valette [mailto:eric.valette@free.fr] 
>>I happily run 2.4.21-pre5 with ACPI enabled and everything works just 
>>fine. I tried today 2.6-pre1 with exactly the same hardware 
>>configuration as the 2.4 one and the laptop does not boot. It hangs 
>>while dispaying : "Executing all Devices _STA and_INIT methods" 
>>allthough it has already printed several '.'
> 
> 
> That's weird. They should have the same version of the ACPI code...


Just to try to help, as suggested by Karol Kasimor, disabling the APIC 
make the code pass this section. The APIC is now really unconditionnaly 
enabled (regardless of BIOS settings) due to this change in 2.5.74...

<http://lists.insecure.org/lists/linux-kernel/2003/Jun/5840.html>

So this is an interaction between APIC and ACPI... I still think it 
should not crash at least...

BTW : I still cannot boot as the radeon framebuffer driver make things 
unreable. I will stcik with 2.4 for a while...

-- eric

