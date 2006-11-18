Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756180AbWKRGmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756180AbWKRGmX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 01:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756184AbWKRGmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 01:42:23 -0500
Received: from terminus.zytor.com ([192.83.249.54]:55252 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1756180AbWKRGmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 01:42:23 -0500
Message-ID: <455EAB28.9000500@zytor.com>
Date: Fri, 17 Nov 2006 22:41:44 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: LKML <linux-kernel@vger.kernel.org>, olecom@flower.upol.cz,
       vgoyal@in.ibm.com, akpm@osdl.org, rjw@sisk.pl, ebiederm@xmission.com,
       Reloc Kernel List <fastboot@lists.osdl.org>, pavel@suse.cz,
       magnus.damm@gmail.com
Subject: Re: [PATCH 20/20] x86_64: Move CPU verification code to common file
References: <20061117223432.GA15449@in.ibm.com> <20061117225953.GU15449@in.ibm.com> <slrnelt6h7.dd3.olecom@flower.upol.cz> <20061118063802.GE30547@bingen.suse.de>
In-Reply-To: <20061118063802.GE30547@bingen.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> May hang be done optional? There was a discussion about applying
>> "panic" reboot timeout here. Is it possible to implement somehow?
> 
> It would be tricky, but might be possible.  But that would be a completely
> new feature -- the kernel has always hung in this case. If you think you need 
> it submit a (followup) patch. But I don't think it's fair to ask Vivek to do it.
> 
> Besides i don't think it would be any useful. panic reboot only
> makes sense if you can recover after reboot. But if your CPU somehow
> suddenly loses its ability to run 64bit code, no reboot of the world will 
> recover.
> 

Not true.  Some bootloaders support a fallback kernel.  This case is 
particular important if one accidentally installs the wrong kernel for 
the machine.

	-hpa
