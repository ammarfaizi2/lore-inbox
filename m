Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUBLTqS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 14:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266567AbUBLTqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 14:46:18 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:7313 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266488AbUBLTqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 14:46:15 -0500
Date: Thu, 12 Feb 2004 11:45:59 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: davidsen@tmr.com, linux-kernel <linux-kernel@vger.kernel.org>
cc: linux-mm mailing list <linux-mm@kvack.org>
Subject: Re: 2.6.2-mjb1
Message-ID: <12180000.1076615159@flay>
In-Reply-To: <200402121431.19876.davidsen@oddball.prodigy.com>
References: <30760000.1076532248@[10.10.2.4]> <200402121431.19876.davidsen@oddball.prodigy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does it go away if you revert these two?

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/patches/2.6.2/2.6.2-mjb1/370-emulex
ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/patches/2.6.2/2.6.2-mjb1/371-multiple_emulex

M.

--On Thursday, February 12, 2004 14:31:19 -0500 Bill Davidsen <davidsen@oddball.prodigy.com> wrote:

> On Wednesday 11 February 2004 03:44 pm, Martin J. Bligh wrote:
>> The patchset is meant to be pretty stable, not so much a testing ground.
>> Main differences from mainline are:
>> 
>> 1. Better performance & resource consumption, particularly on larger
>> machines. 2. Diagnosis tools (kgdb, early_printk, etc).
>> 3. Updated arch support for AMD64 + PPC64.
>> 4. Better support for sound, especially OSS emulation over ALSA.
>> 5. Better support for video (v4l2, bttv, ivtv).
>> 6. Kexec support.
>> 
>> I'd be very interested in feedback from anyone willing to test on any
>> platform, however large or small.
>> 
>> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.6.2/patch-2.6.2-mjb1.
>> bz2
>> 
>> Since 2.6.1-mjb1 (~ = changed, + = added, - = dropped)
> 
> The first thing I notice is that "make rpm" didn't work, and failed with the 
> error code at the bottom of this message. Too bad, since I've been building 
> RPMs on a big fast WBEL-3.0 four way Xeon, but have to run them on a humble 
> PII-350. Forgive me, I do NOT want to build kernels on the test machine, it 
> takes forever and needs a bit of temp space tweaking as well.
> 
> Built clean by itself, I just can't move and install it easily.
> 
> ~~~~~~~~~~~~~~~~~~~~
> 
> + umask 022
> + cd /usr/src/redhat/BUILD
> + LANG=C
> + export LANG
> + unset DISPLAY
> + exit 0
> Executing(%build): /bin/sh -e /var/tmp/rpm-tmp.33180
> + umask 022
> + cd /usr/src/redhat/BUILD
> + LANG=C
> + export LANG
> + unset DISPLAY
> + rm -rf /tmp/lpfc-LPFC_DRIVER_VERSION
> + mkdir -p /tmp/lpfc-LPFC_DRIVER_VERSION/lpfc-LPFC_DRIVER_VERSION
> + cd lpfc-LPFC_DRIVER_VERSION
> /var/tmp/rpm-tmp.33180: line 28: cd: lpfc-LPFC_DRIVER_VERSION: No such file or 
> directory
> error: Bad exit status from /var/tmp/rpm-tmp.33180 (%build)
> 
> 
> RPM build errors:
>     Bad exit status from /var/tmp/rpm-tmp.33180 (%build)
> make: *** [rpm] Error 1
> 
> -- 
> Bill Davidsen, TMR
> 
> 


