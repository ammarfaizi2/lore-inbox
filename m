Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755847AbWKRAqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847AbWKRAqN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754078AbWKRAqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:46:13 -0500
Received: from terminus.zytor.com ([192.83.249.54]:35728 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1755847AbWKRAqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:46:13 -0500
Message-ID: <455E57BA.7060309@zytor.com>
Date: Fri, 17 Nov 2006 16:45:46 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
Subject: Re: [PATCH 19/20] x86_64: Extend bzImage protocol for relocatable
 kernel
References: <20061117223432.GA15449@in.ibm.com> <20061117225826.GT15449@in.ibm.com> <455E540C.6090202@zytor.com> <20061118003718.GB4321@in.ibm.com>
In-Reply-To: <20061118003718.GB4321@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:
> On Fri, Nov 17, 2006 at 04:30:04PM -0800, H. Peter Anvin wrote:
>> Vivek Goyal wrote:
>>> o Extend the bzImage protocol (same as i386) to allow bzImage loaders to
>>>  load the protected mode kernel at non-1MB address. Now protected mode
>>>  component is relocatable and can be loaded at non-1MB addresses.
>>>
>>> o As of today kdump uses it to run a second kernel from a reserved memory
>>>  area.
>>>
>>> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
>> Do you have a patch for Documentation/i386/boot.txt as well?
>>
> 
> Yes. As documentation is shared between i386 and x86_64, It is already there
> in Andi's tree and in -mm. I had pushed that with i386 relocatable bzImage
> changes.
> 
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm2/broken-out/x86_64-mm-extend-bzimage-protocol-for-relocatable-protected-mode-kernel.patch
> 

Your documentation change is buggy.

The fields at 0230/4 and 0234/1 are 2.05+ not 2.04+

Please fix, also please update the last revision date.

	-hpa
