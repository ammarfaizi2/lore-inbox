Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVAGRpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVAGRpB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVAGRoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:44:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:47071 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261359AbVAGRnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:43:19 -0500
Message-ID: <41DEC0BF.4010708@osdl.org>
Date: Fri, 07 Jan 2005 09:02:55 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, paulmck@us.ibm.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, Linus Torvalds <torvalds@osdl.org>, linux@brodo.de
Subject: Re: [PATCH] add feature-removal-schedule.txt documentation
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org> <20050106235633.GA10110@kroah.com>
In-Reply-To: <20050106235633.GA10110@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------080300010808010205030505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080300010808010205030505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Thu, Jan 06, 2005 at 03:26:21PM -0800, Andrew Morton wrote:
> 
>>Which begs the question "how do we ever get rid of these things when we
>>have no projected date for Linux-2.8"?
>>
>>I'd propose:
>>
>>a) Create Documentation/feature-removal-schedule.txt which describes
>>   things which are going away, when, why, who is involved, etc.
> 
> Ok, I'll bite, here's a patch that does just that.  Look good?

Brodo, can you add a little more info to this, please?

---
Add 2.4.x cpufreq /proc and sysctl interface removal
to the feature-removal-schedule.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
  Documentation/feature-removal-schedule.txt |    9 +++++++++
  1 files changed, 9 insertions(+)

---

--------------080300010808010205030505
Content-Type: text/x-patch;
 name="cpufreq_sched.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpufreq_sched.patch"


diff -Naurp ./Documentation/feature-removal-schedule.txt~cpufreq ./Documentation/feature-removal-schedule.txt
--- ./Documentation/feature-removal-schedule.txt~cpufreq	2005-01-07 08:48:26.568969672 -0800
+++ ./Documentation/feature-removal-schedule.txt	2005-01-07 08:55:50.658457808 -0800
@@ -15,3 +15,12 @@ Why:	It has been unmaintained for a numb
 	against the LSB, and can be replaced by using udev.
 Who:	Greg Kroah-Hartman <greg@kroah.com>
 
+---------------------------
+
+What:	/proc/sys/cpu and the sysctl interface to cpufreq (2.4.x interfaces)
+When:	January 2005
+Files:	drivers/cpufreq/: cpufreq_userspace.c, proc_intf.c
+	function calls throughout the kernel tree
+Why:	Deprecated, has been replaced/superseded by (what?)....
+Who:	Dominik Brodowski <linux@brodo.de>
+

--------------080300010808010205030505--
