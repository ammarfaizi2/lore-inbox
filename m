Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263879AbUD0H5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbUD0H5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 03:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263884AbUD0H5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 03:57:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:42216 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263879AbUD0H5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 03:57:10 -0400
X-Authenticated: #4512188
Message-ID: <408E125D.1030806@gmx.de>
Date: Tue, 27 Apr 2004 09:57:17 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040413)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: ACPI broken on nforce2?
References: <200404131117.31306.ross@datscreative.com.au>	 <200404131703.09572.ross@datscreative.com.au>	 <1081893978.2251.653.camel@dhcppc4>	 <200404160110.37573.ross@datscreative.com.au>	 <1082060255.24425.180.camel@dhcppc4>	 <1082063090.4814.20.camel@amilo.bradney.info>	 <1082578957.16334.13.camel@dhcppc4> <4086E76E.3010608@gmx.de>	 <1082587298.16336.138.camel@dhcppc4>  <20040422163958.GA1567@tesore.local>	 <1082654469.16333.351.camel@dhcppc4> <1082669345.16332.411.camel@dhcppc4>
In-Reply-To: <1082669345.16332.411.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we once had this subject a bit, but it doesn't seem to be fully 
resolved. It is still about the C1 halt state. Perhaps you remember me 
having trouble getting low idle temps with my nforce2 and Athlon XP. 
WIth a previous kernel I could get them back using agpgart and nvidia 
binary. But now (2.6.6-rc2-mm1) even using the open source nvidia 
driver, idle temps seem to do whatever they like (no matter if PIC or 
APIC is used). I really think that the C1 state isn't called properly. 
(cpu disconnect is activated)

cat /proc/acpi/processor/CPU0/power
active state:            C1
default state:           C1
bus master activity:     00000000
states:
    *C1:                  promotion[--] demotion[--] latency[000] 
usage[00000000]
     C2:                  <not supported>
     C3:                  <not supported>

You told that the usage probably keeps 0 as it is not counted. But this 
makes me wonder: Yesterday with I tried acpi=force on a board with VIA 
MVP3 chipset. The bios is from 2000 and guess what, here C1 and even C2 
  semm to be used properly and the usage is even counted. ACPI seems to 
work better than on my nforce2...

So I wonder why on nforce2 C1 usage isn't counted. I now have the strong 
feeling that is itn't properly called under some circumstances.

Should I open a bug report? If yes, what files do you need?

Thanks,

Prakash
