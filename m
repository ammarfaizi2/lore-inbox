Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263991AbUD0LBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263991AbUD0LBc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 07:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264000AbUD0LBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 07:01:32 -0400
Received: from mail.inf.tu-dresden.de ([141.76.2.1]:39307 "EHLO
	mail.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S263991AbUD0LBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 07:01:14 -0400
Message-ID: <408E3D74.2090301@inf.tu-dresden.de>
Date: Tue, 27 Apr 2004 13:01:08 +0200
From: Christoph Pohl <christoph.pohl@inf.tu-dresden.de>
Organization: TU Dresden, Dept. CS
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: de, en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Low bogomips on IBM x445 (kernel 2.6.5)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm currently configuring an IBM x445 box with 4 Xeon CPUs (3GHz) and 
hyperthreading enabled. Everything seems to work fine since kernel 2.6.5 
but I keep wondering about the *very low* Bogomips numbers. Here is what 
I see in /proc/cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 3.00GHz
stepping        : 7
cpu MHz         : 2996.175
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 193.53

(...)

processor       : 7
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 3.00GHz
stepping        : 7
cpu MHz         : 2996.175
cache size      : 512 KB
physical id     : 25
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 199.16

199 bogomips seems to be pretty low for my taste, although the box seems 
to work fine (and fast).

I came accross two bugs that looked very similar. However, they were 
filed agains 2.4.x and should have been fixed for 2.6.x:

http://www.ussg.iu.edu/hypermail/linux/kernel/0311.0/0329.html

http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=115061

Any ideas?

Best regards,
Christoph

PS: Please CC me, I didn't subscribe to the list!
