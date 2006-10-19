Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946092AbWJSOgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946092AbWJSOgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946089AbWJSOgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:36:13 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:31382 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1946096AbWJSOgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:36:11 -0400
Message-ID: <45378D59.4060200@s5r6.in-berlin.de>
Date: Thu, 19 Oct 2006 16:36:09 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Daniel Drake <ddrake@brontes3d.com>, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Unnecessary BKL contention in video1394
References: <1161203487.28713.8.camel@systems03.lan.brontes3d.com>	<45369E69.30007@s5r6.in-berlin.de>	<1161263978.2845.6.camel@systems03.lan.brontes3d.com> <200610191527.42802.ak@suse.de>
In-Reply-To: <200610191527.42802.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
[Daniel Drake wrote:]
>> Adding Andi Kleen to CC, who added the BKL around __video1394_ioctl a
>> long while back (when converting video1394 to compat_ioctl).
>> 
>> I don't feel that any replacement protection is needed, since the
>> critical sections (where structures are used both in interrupts and in
>> file_operations) are already protected by spinlocks.
> 
> Fine by me. I just did it to preserve old semantics because I didn't want
> to audit the 1394 locking.  But if you think it's not needed feel free to remove
> them.

Thanks for the info. Daniel, do you want to resend a signed-off patch?
And __video1394_ioctl and its wrapper video1394_ioctl can certainly be
merged then.
-- 
Stefan Richter
-=====-=-==- =-=- =--==
http://arcgraph.de/sr/
