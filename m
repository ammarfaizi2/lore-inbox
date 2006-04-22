Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWDVSbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWDVSbm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 14:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWDVSbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 14:31:41 -0400
Received: from dougal.buttersideup.com ([195.200.137.69]:30621 "EHLO
	dougal.buttersideup.com") by vger.kernel.org with ESMTP
	id S1750881AbWDVSbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 14:31:40 -0400
Message-ID: <444A7684.2020800@buttersideup.com>
Date: Sat, 22 Apr 2006 19:31:32 +0100
From: Tim Small <tim@buttersideup.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Gross, Mark" <mark.gross@intel.com>
Cc: Doug Thompson <dthompson@lnxi.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Problems with EDAC coexisting with BIOS
References: <5389061B65D50446B1783B97DFDB392D9D3ED3@orsmsx411.amr.corp.intel.com>
In-Reply-To: <5389061B65D50446B1783B97DFDB392D9D3ED3@orsmsx411.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gross, Mark wrote:

>You can never predict when a SMI will bubble through the system.  Even
>if you handle case where the BIOS re-hides Dev0:Fun1 and not panic how
>do you deal with the race between the BIOS SMI based handling and the
>driver?  Who will end up reading (and clearing) the error registers
>first?  There is no good way to share today.
>  
>
You could (at least from memory, on certain chipsets) modify the error 
reporting registers so that an SMI is no longer generated as a result of 
MC ECC errors.  True, this doesn't fix many of the other problems 
related to this issue, but would be useful in a "modprobe xyz_edac 
force_unhide_MC_PCI=1" case.

Closed-source BIOSes eh?  Who needs em ;-p.

Tim.

