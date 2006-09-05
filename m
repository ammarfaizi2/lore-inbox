Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbWIEN2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWIEN2W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 09:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWIEN2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 09:28:22 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:61098 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964968AbWIEN2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 09:28:21 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take15 1/4] kevent: Core files.
Date: Tue, 5 Sep 2006 15:28:17 +0200
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
References: <1157364862688@2ka.mipt.ru>
In-Reply-To: <1157364862688@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609051528.18437.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 September 2006 12:14, Evgeniy Polyakov wrote:

> +asmlinkage long sys_kevent_get_events(int ctl_fd, unsigned int min_nr,
> 		unsigned int max_nr, __u64 timeout, void __user *buf,
> 		unsigned flags) 
> +asmlinkage long sys_kevent_ctl(int fd, unsigned int cmd, unsigned int num,
> 		void __user *arg) 

'void __user *arg' in both of these always points to a struct ukevent,
according to your documentation. Shouldn't it be a 
'struct ukevent __user *arg' then?

	Arnd <><
