Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWFGDOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWFGDOm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 23:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWFGDOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 23:14:42 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:35808 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750713AbWFGDOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 23:14:41 -0400
Message-ID: <448643B9.2080805@jp.fujitsu.com>
Date: Wed, 07 Jun 2006 12:10:49 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [BUG][PATCH 2.6.17-rc5-mm3] bugfix: PCI legacy I/O port free
 driver
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com> <4484263C.1030508@jp.fujitsu.com> <20060606075812.GB19619@kroah.com>
In-Reply-To: <20060606075812.GB19619@kroah.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Jun 05, 2006 at 09:40:28PM +0900, Kenji Kaneshige wrote:
> 
>>Hi Andrew, Greg,
>>
>>Here is a patche to fix a bug that pci_request_regions() doesn't work
>>when it is called after pci_disable_device(), which was reported at:
>>
>>    http://marc.theaimsgroup.com/?l=linux-kernel&m=114914585213991&w=2
>>
>>This bug is introduced by the following "PCI legacy I/O port free
>>driver" patches currently in 2.6.17-rc5-mm3.
>>
>>    o gregkh-pci-pci-legacy-i-o-port-free-driver-changes-to-generic-pci-code.patch
>>    o gregkh-pci-pci-legacy-i-o-port-free-driver-make-emulex-lpfc-driver-legacy-i-o-port-free.patch
>>    o gregkh-pci-pci-legacy-i-o-port-free-driver-make-intel-e1000-driver-legacy-i-o-port-free.patch
>>    o gregkh-pci-pci-legacy-i-o-port-free-driver-update-documentation-pci_txt.patch
>>
>>This patch is against 2.6.17-rc5-mm3. Please see the header of the
>>patch about details.
>>
>>If reposting the fixed version of PCI legacy I/O port free driver
>>patches against the latest Linus tree are preferred rather than this
>>patch, please let me know.
> 
> 
> I think a new set of patches would be the best, as that way when I apply
> them to Linus's tree, there is no point in the patch history that has a
> problem that people might hit.
> 
> So, care to just resend the above 4 patches with your fix included?  Is
> that easy to do?
> 

Hi Greg,

Here is a updated set of patches for PCI legacy I/O port free driver
patches. It is against 2.6.17-rc6. It contains the following patches.

    o [PATCH 1/4] Changes to generic pci code
    o [PATCH 2/4] Update Documentation/pci.txt
    o [PATCH 3/4] Make Intel e1000 driver legacy I/O port free
    o [PATCH 4/4] Make Emulex lpfc driver legacy I/O port free

Each of them are corresponding to the following patches in your tree.

    o pci-legacy-i-o-port-free-driver-changes-to-generic-pci-code.patch
    o pci-legacy-i-o-port-free-driver-update-documentation-pci_txt.patch
    o pci-legacy-i-o-port-free-driver-make-intel-e1000-driver-legacy-i-o-port-free.patch
    o pci-legacy-i-o-port-free-driver-make-emulex-lpfc-driver-legacy-i-o-port-free.patch

Thanks,
Kenji Kaneshige


