Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291677AbSBNOKN>; Thu, 14 Feb 2002 09:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291675AbSBNOJ6>; Thu, 14 Feb 2002 09:09:58 -0500
Received: from nuustak.csir.co.za ([146.64.10.11]:52153 "EHLO
	nuustak.csir.co.za") by vger.kernel.org with ESMTP
	id <S291666AbSBNOJg>; Thu, 14 Feb 2002 09:09:36 -0500
Disclaimer: The CSIR exercises no editorial control over E-mail
		messages originating in the organisation and the views in this
		message are therefore not necessarily those of the CSIR and/or
		its employees.
Message-Id: <sc6be105.019@CS-IMO.CSIR.CO.ZA>
X-Mailer: Novell GroupWise Internet Agent 6.0.1
Date: Thu, 14 Feb 2002 16:08:20 +0200
From: "Herman Theron" <HEtheron@csir.co.za>
To: <linux-kernel@vger.kernel.org>
Subject: NS Geode: Is it OK to enable TSC [2.4.x]
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I'm running a SBC computer with a NS Geode GX1-233 processor.
Normallly, you can only compile the kernel with the CONFIG_M586 option.
Doing some experimentation, I enabled the TSC in the file:
/usr/src/linux/arch/i386/kernel/setup.c (by commenting out the
"clear_bit(X86_FEATURE_TSC...." for the GX processor in the function
"init_cyrix". I then compiled the kernel then with CONFIG_M586MMX. So
far the system is running non-stop (without any apparent problems) for
24 hours with a RTAI-application aswell.

This is the info I get from 'cat /proc/cpuinfo'
processor	: 0
vendor_id	: CyrixInstead
cpu family	: 5
model		: 9
model name	: Geode(TM) Integrated Processor by National Semi
stepping	: 1
cpu MHz		: 232.742
cache size	: 16 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu tsc msr cx8 cmov mmx cxmmx
bogomips	: 463.66

Is there any test that I can do to make sure it works OK? And if so,
can the kernel then be modified to reflect this?

Thanks for any info
Herman

****************************************
Herman Theron
Hermanus Magnetic Observatory
CSIR
PO Box 32
Hermanus
7200
South Africa
E-mail: hetheron@csir.co.za
Phone: +27 28 3121196
Fax: +27 28 3122039
Cel: +27 833 206 311
