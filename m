Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161821AbWKIUHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161821AbWKIUHA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 15:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965559AbWKIUHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 15:07:00 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:39882 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965546AbWKIUHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 15:07:00 -0500
Message-ID: <45538A4E.6040404@sgi.com>
Date: Thu, 09 Nov 2006 12:06:38 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Don Zickus <dzickus@redhat.com>
CC: "Lu, Yinghai" <yinghai.lu@amd.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Kexec with latest kernel fail
References: <5986589C150B2F49A46483AC44C7BCA49071BF@ssvlexmb2.amd.com> <20061109163922.GE5622@redhat.com>
In-Reply-To: <20061109163922.GE5622@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Zickus wrote:
> On Wed, Nov 08, 2006 at 08:07:22PM -0800, Lu, Yinghai wrote:
>> Eric,
>>
>> I got "Invalid memory segment 0x100000 - ..."
>> using kexec latest kernel...
> 
> I usually see this when people forget to add the "crashkernel=X@Y" into
> their /etc/grub.conf kernel command line.  Where X and Y are arch
> specific.

I have had "Invalid memory segment 0x4000000 - 0x4997fff" problem with
'-l' option _always_. Since my priority was on '-p' i did not spent time
on debugging this problem yet...

Maybe this "crashkerenl=X@Y" was the cause of my problem? Some platform
can not specify a location to load so that it is legal to only specify
"crashkernel=X" now. Is it possible '-l' code path still expect to
see Y?

Thanks,
 - jay

> 
> Cheers,
> Don
> 
