Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbUCIToc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbUCIThm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:37:42 -0500
Received: from pop.gmx.net ([213.165.64.20]:35295 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262135AbUCITef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:34:35 -0500
X-Authenticated: #7370606
Message-ID: <404E1C42.8040707@gmx.at>
Date: Tue, 09 Mar 2004 20:34:26 +0100
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>, evms-devel@lists.sourceforge.net
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Evms-devel] Re: evms plugin for hptraid support <<<pre-alpha>>>
References: <403FB3B1.7050600@gmx.at> <20040309143131.098c1033.vsu@altlinux.ru>
In-Reply-To: <20040309143131.098c1033.vsu@altlinux.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov wrote:
> On Fri, 27 Feb 2004 22:16:33 +0100 Wilfried Weissmann wrote:
> 
> 
>>this is my attempt to add support for the ataraid devices to the 2.6 
>>kernel. the code is as far as possible from being mature and useable as 
>>one could imagine (i have not even requested any plugin-ids for the evms 
>>engine). for now it only detects the HPT370A controller, because of i am 
>>  checking the pci-ids of the controller to prevent that any non-raid 
>>disks are stolen by the raid module. this would happen with the current 
>>ataraid code from the kernel v2.4.
> 
> 
> I'm not sure if this PCI ID checking is a good thing.  With ataraid
> drivers, if your FakeRAID controller gets broken for some reason, you
> can just attach the disks to any available IDE controller and get
> access to your data.  With the proposed PCI ID check this ability will
> be lost.
> 
> The problem with stale RAID superblocks on disks may be solved by
> adding a command to clear the RAID superblocks without touching the
> rest of data.

I can create a configuration option that controls or disables the PCI 
check. Claiming all disks that have raid signatures is a great feature 
for debugging and disaster recovery, but I think that if this is the 
default then it is more trouble than it is worth.

Regards,
Wilfried
