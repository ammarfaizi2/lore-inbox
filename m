Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267668AbUIXA7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267668AbUIXA7s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266517AbUIXA44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:56:56 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:47778 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267632AbUIXArX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:47:23 -0400
Date: Fri, 24 Sep 2004 09:49:09 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] add hook for PCI resource deallocation
In-reply-to: <20040917214943.GE14340@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-id: <41536F05.6040602@jp.fujitsu.com>
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

Greg,

Today, we have a PCI IRQ resource deallocation patch (please see the
links below). Ia64 portion of IRQ resource deallocation patch is
waiting this hook to be applied, because it depends on this hook.

So please apply this hook.

PCI IRQ resource deallocation patches:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109575695503290&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=109575695526462&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=109575721322332&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=109575753325729&w=2

Thanks,
Kenji Kaneshige

