Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264461AbUFHWoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbUFHWoQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 18:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265370AbUFHWoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 18:44:16 -0400
Received: from web21004.mail.yahoo.com ([216.136.227.58]:4265 "HELO
	web21004.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264461AbUFHWoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 18:44:14 -0400
Message-ID: <20040608224413.93994.qmail@web21004.mail.yahoo.com>
Date: Tue, 8 Jun 2004 15:44:13 -0700 (PDT)
From: athul acharya <nyte2k@yahoo.com>
Subject: Dothan/Centrino cpufreq
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

I noticed that 2.6.7-rc1 was supposed to have Dothan
support for cpufreq, but since neither it nor -rc2
worked  on my machine, I decided to take a look at the
code and see if I couldn't figure something out.  I
saw this:

static const struct cpu_id cpu_id_dothan_a1 = {
        .x86_vendor = X86_VENDOR_INTEL,
        .x86 = 6,
        .x86_model = 13,
        .x86_mask = 1,
};

Attempting to match this against /proc/cpuinfo, I
changed it to

static const struct cpu_id cpu_id_dothan_a1 = {
        .x86_vendor = X86_VENDOR_INTEL,
        .x86 = 6,
        .x86_model = 13,
        .x86_mask = 6,
};

This worked, creating
/sys/devices/system/cpu/cpu0/cpufreq/ and the whole
shebang.  So, for whomever is in charge of cpufreq,
the above change needs to be integrated in order for
(some?) Dothans to work.

Since I don't currently subscribe to linux-kernel, I
would appreciate it if any replies/etc could be CC'd
to me, nyte2k@yahoo.com

Thanks,

Athul Acharya


	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
