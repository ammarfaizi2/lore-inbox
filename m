Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267447AbUIUBd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267447AbUIUBd0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 21:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267451AbUIUBd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 21:33:26 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:60323 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267447AbUIUBdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 21:33:22 -0400
Date: Tue, 21 Sep 2004 10:35:12 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] add hook for PCI resource deallocation
In-reply-to: <20040917214943.GE14340@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-id: <414F8550.6020209@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
References: <41498CF6.9000808@jp.fujitsu.com> <20040917214943.GE14340@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Sep 16, 2004 at 09:54:14PM +0900, Kenji Kaneshige wrote:
>> Hi,
>> 
>> This patch adds a hook 'pcibios_disable_device()' into
>> pci_disable_device() to call architecture specific PCI resource
>> deallocation code. It's a opposite part of pcibios_enable_device().
>> We need this hook to deallocate architecture specific PCI resource
>> such as IRQ resource, etc.. This patch is just for adding the hook,
>> so pcibios_disable_device() is defined as a null function on all
>> architecture so far.
> 
> I'd prefer to wait until there was an actual user of this hook before
> adding it to the kernel.  Otherwise someone (likely me) will notice this
> hook in a few days and go, "hey, no one is using this, let's clean it
> up" :)
> 
> So, how about we wait until you have a patch that needs this before I
> apply it?
> 

Okay.
I'll post a patch that needs this soon.

Thanks,
Kenji Kaneshige

