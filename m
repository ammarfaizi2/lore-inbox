Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbVJEVcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbVJEVcA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVJEVb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:31:59 -0400
Received: from [194.90.79.130] ([194.90.79.130]:9232 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1030314AbVJEVb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:31:59 -0400
Message-ID: <43444647.4040401@argo.co.il>
Date: Thu, 06 Oct 2005 00:31:51 +0300
From: avi <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PAE causing failure to run various executables.
References: <20051005204035.GB10640@redhat.com>
In-Reply-To: <20051005204035.GB10640@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Oct 2005 21:31:55.0193 (UTC) FILETIME=[35370A90:01C5C9F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>A fedora user recently filed a puzzling bug at
>https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=169741
>
>The system being reported has exactly 4GB, and its E820
>tables seem to concur that there is in fact 4GB.
>
>When run in non-PAE mode, it triggers the
>"Warning only 4GB will be used. Use a PAE enabled kernel."
>message, which is odd, but the system does actually run.
>
>  
>
if there's a hole in the physical address space (for pci devices), you 
would need more than 32 bits to address 4GB RAM.

>When run in PAE mode, it seems to lose its mind, and it
>fails to run various binaries.
>
>Booting with mem=4G causes the machine to boot fine
>(though for some reason, it finds only 3042M of RAM).
>
>  
>
looks like a 1GB hole.


>The reporter of this bug has tested on 2.6.14-rc3-git4, and found the
>same issue exists as he saw on the original FC3 kernel, thus ruling out
>any Fedora-specific patches.
>
>Anyone have any ideas what's wrong here?
>
>		
>
maybe the last 1GB is bad. since it can only be accessed by pae, only 
the pae kernel fails.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

