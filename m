Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271411AbTG2L7x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 07:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271412AbTG2L7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 07:59:53 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:60143 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271411AbTG2L7w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 07:59:52 -0400
Subject: Re: malloc problem to allocate very large blocks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: nagendra_tomar@adaptec.com
Cc: Tung-Han Hsieh <thhsieh@xcin.phys.ntu.edu.tw>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jamagallon@able.es
In-Reply-To: <Pine.LNX.4.44.0307291027230.17227-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0307291027230.17227-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059479571.3118.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jul 2003 12:52:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-29 at 05:58, Nagendra Singh Tomar wrote:
> AFAIK malloc will not return you memory more than the total virtual memory 
> (RAM+swap) in the system. So if you want more than 2GB allocations from 
> malloc, make sure you have at least 2GB virtual mem, keeping aside some 
> space for the kernel.

On the default memory settings it may do. However a request for 2Gb of
memory requires there is a free 2Gb of address space to map it into -
which may not be true because of things like shared libraries. 

The actual total allocatable limit for x86 is a bit under 3Gb, but you 
won't get that as one linear allocation. (1Gb is kernel mappings)

