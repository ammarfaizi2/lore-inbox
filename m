Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268313AbTAMURE>; Mon, 13 Jan 2003 15:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268317AbTAMURE>; Mon, 13 Jan 2003 15:17:04 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:10681 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S268313AbTAMUQb>; Mon, 13 Jan 2003 15:16:31 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD8E9@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: APIC version
Date: Mon, 13 Jan 2003 14:21:54 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wow, this is pretty brilliant, Jun! In cases like this one always thinks
"Why this didn't occur to me, this is so obvious..." 
(Sadly I noticed that I tend to go "round and about" sometimes instead of
direct :(
I hope this will get incorporated in the source tree.

Thanks,

--Natalie 


-----Original Message-----
From: Nakajima, Jun [mailto:jun.nakajima@intel.com]
Sent: Monday, January 13, 2003 1:13 PM
To: Protasevich, Natalie; Martin J. Bligh; Pallipadi, Venkatesh
Cc: William Lee Irwin III; Christoph Hellwig; James Cleverdon; Linux
Kernel
Subject: RE: APIC version


The only thing you need to do is 
	processor.mpc_type = MP_PROCESSOR;
 	processor.mpc_apicid = id;
-	processor.mpc_apicver = 0x10; /* TBD: lapic version */
+	processor.mpc_apicver = GET_APIC_VERSION(apic_read(APIC_LVR));
 	processor.mpc_cpuflag = (enabled ? CPU_ENABLED : 0);
 	processor.mpc_cpuflag |= (boot_cpu ? CPU_BOOTPROCESSOR : 0);
 	processor.mpc_cpufeature = (boot_cpu_data.x86 << 8) |

Jun

>
