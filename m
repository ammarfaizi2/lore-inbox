Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264591AbTLEXCX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 18:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264592AbTLEXCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 18:02:23 -0500
Received: from may.nosdns.com ([207.44.240.96]:8636 "EHLO may.nosdns.com")
	by vger.kernel.org with ESMTP id S264591AbTLEXCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 18:02:20 -0500
Date: Fri, 5 Dec 2003 16:02:13 -0700
From: "Russell \"Elik\" Rademacher" <elik@webspires.com>
X-Mailer: The Bat! (v2.00.6) Business
Reply-To: "Rusell \"Elik\" Rademacher" <elik@webspires.com>
X-Priority: 3 (Normal)
Message-ID: <86101410218.20031205160213@webspires.com>
To: linux-kernel@vger.kernel.org
Subject: Re[2]: HT apparently not detected properly on 2.4.23
In-Reply-To: <3FD0CD65.5080307@stinkfoot.org>
References: <20031203235837.GW8039@holomorphy.com>
 <Pine.LNX.4.44.0312051511440.5412-100000@logos.cnet>
 <20031205174850.GE8039@holomorphy.com>
 <17783749062.20031205110751@webspires.com> <3FD0CD65.5080307@stinkfoot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - may.nosdns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - webspires.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ethan,

   Seems that patch of yours finally did the job of reporting it right this time around.  I had to gank a few servers of different versions and giving the webhosting customers some little inconvience of downtime of 3 to 10 minutes for the linux recompile and reboot.  And they all finally reports the number of processors correctly as it should be.

   Thanks Ethan.  I going to put it on more servers that got those and see how they all go as well.  As for the servers, they are all usually ServerWorks, Intel Chipsets of various types with Intel E1000, E100, Realtek network ports and with 3Ware or SCSI Adaptec adapters.  Got about 80 of them in various types to go though, but 5 of them I that tested it on, it all reports correctly.

   Let see if the Dell servers also report the same as well when I get though with them tonight.

Friday, December 5, 2003, 11:24:37 AM, you wrote:

Ethan Weinstein> Russell "Elik" Rademacher wrote:
>> Hmmmm.....
>> 
>>     SO someone finally realized that HT is not being detected properly
>> dispite all the boot time parameters in the lilo/grub with APIC turned on? 
>> It just seems to be a major problem since 2.4.21 version and I was hoping it
>> was resolved. :)
>> 
>>     This patch you mentioned, can you send a copy to me as well?  Just
>> want to get my clients off my back. :)
>> 
>> 

Ethan Weinstein> heheh. Welcome to linux-kernel.  Try running
Ethan Weinstein> an arch other than x86 if 
Ethan Weinstein> you _really_ like having your problems ignored =)


Ethan Weinstein> ===== arch/i386/kernel/smpboot.c 1.17 vs edited =====
Ethan Weinstein> --- 1.17/arch/i386/kernel/smpboot.c    Mon Nov  3 05:48:33 2003
Ethan Weinstein> +++ edited/arch/i386/kernel/smpboot.c    Wed Dec  3 16:45:27 2003
Ethan Weinstein> @@ -1106,7 +1106,7 @@
Ethan Weinstein>        */
Ethan Weinstein>       Dprintk("CPU present map: %lx\n", phys_cpu_present_map);

Ethan Weinstein> -    for (bit = 0; bit < NR_CPUS; bit++) {
Ethan Weinstein> +    for (bit = 0; bit < BITS_PER_LONG; bit++) {
Ethan Weinstein>           apicid = cpu_present_to_apicid(bit);
Ethan Weinstein>           /* don't try to boot BAD_APICID */





-- 
Best regards,
Russell "Elik" Rademacher
Freelance Remote System Adminstrator/Tech Support

