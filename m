Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030539AbVIPAoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030539AbVIPAoz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 20:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030547AbVIPAoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 20:44:55 -0400
Received: from fmr17.intel.com ([134.134.136.16]:27555 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030539AbVIPAoy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 20:44:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [OOPS] hotplugging cpus via /sys/devices/system/cpu/
Date: Fri, 16 Sep 2005 08:44:47 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F16BBECA@pdsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [OOPS] hotplugging cpus via /sys/devices/system/cpu/
Thread-Index: AcW1gPjHMu6fL1oGS5OnZ73hgLIlSQE1lbBA
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Raj, Ashok" <ashok.raj@intel.com>, "Christopher Beppler" <psiml@funzi.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Sep 2005 00:44:48.0982 (UTC) FILETIME=[D7781760:01C5BA57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>On Fri, Sep 09, 2005 at 01:41:58PM -0700, Christopher Beppler wrote:
>>
>>    [1.] One line summary of the problem:
>>    If I deactivate a CPU with /sys/devices/system/cpux and try to
>>    reactivate it, then the CPU doesn't start and the kernel prints
out an
>>    oops.
>>
>
>Could you try this on 2.6.13-mm2? If this is due to a sending broadcast
>IPI related issue that should fix the problem.
>
>I should say i didnt try i386 in a while
>but i suspect some of the recent suspend/resume code required some
>modifications to the i386 hotplug code which might be getting in the
way
>if you just try logical cpu hotplug alone without using it for
>suspend/resume.
>
>Shaohua might know more about the status.
Sorry for the long delay, I missed this email (Ashok misspelled my email
address :)). The sysfs interface works for me. And please note I didn't
do status clear/__init call cleanup for non-intel CPU, as I haven't any
machine with non-intel CPUs here to test.

Thanks,
Shaohua
