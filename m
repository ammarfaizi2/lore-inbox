Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWBXR4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWBXR4j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 12:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWBXR4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 12:56:39 -0500
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:12517 "EHLO
	smtpq2.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932405AbWBXR4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 12:56:38 -0500
Message-ID: <43FF48F2.70508@keyaccess.nl>
Date: Fri, 24 Feb 2006 18:57:06 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <1140707358.4672.67.camel@laptopd505.fenrus.org> <200602231700.36333.ak@suse.de> <1140713001.4672.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org> <43FE0B9A.40209@keyaccess.nl> <Pine.LNX.4.64.0602231133110.3771@g5.osdl.org> <43FE1764.6000300@keyaccess.nl> <Pine.LNX.4.64.0602231517400.3771@g5.osdl.org> <43FE4B00.8080205@keyaccess.nl> <m1r75s3kfi.fsf@ebiederm.dsl.xmission.com> <43FF26A8.9070600@keyaccess.nl> <m17j7kda52.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0602240925170.3771@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602240925170.3771@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> The real issue is the _physical_ address. Nothing else matters.
> 
> If the TLB splitting on the fixed MTRRs is an issue, it depends entirely 
> on what physical address the kernel resides in, and the virtual address is 
> totally inconsequential.
> 
> So playing games with virtual mapping has absolutely no upsides, and it 
> definitely has downsides.

The notion was that having a fixed virtual mapping of the kernel would 
allow it to be loaded anywhere physically without needing to do actual 
address fixups. The bootloader could then for example at runtime decide 
to load the kernel at 16MB if the machine had enough memory available, 
to free up ZONE_DMA. Or not do that if running on a <= 16MB machine.

Or the kdump "host" kernel would make that decission, as it seems the 
want is shared with them. Eric Biederman said that fixups aren't that 
bad though...

Rene.

