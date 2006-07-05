Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWGECyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWGECyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 22:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWGECyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 22:54:24 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:46813 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932449AbWGECyX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 22:54:23 -0400
Message-ID: <44AB29D3.9090106@vandrovec.name>
Date: Wed, 05 Jul 2006 04:54:11 +0200
From: Petr Vandrovec <petr@vandrovec.name>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.13) Gecko/20060620 Debian/1.7.13-0.2
X-Accept-Language: en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: Alexey Dobriyan <adobriyan@gmail.com>, mingo@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add note that lockdep is not allowed with non-GPL modules
References: <20060704202904.GA24150@vana.vc.cvut.cz> <20060704205328.GA7598@martell.zuzino.mipt.ru>            <44AADBB5.9080307@vandrovec.name> <200607050247.k652lkaD006629@turing-police.cc.vt.edu>
In-Reply-To: <200607050247.k652lkaD006629@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jul 2006 02:54:21.0620 (UTC) FILETIME=[50F18740:01C69FDE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Tue, 04 Jul 2006 23:20:53 +0200, Petr Vandrovec said:
> 
>>>Lock validor found a bug in NVidia driver, film at 11.
> 
> 
> It almost certainly didn't, as you have to do some major ugly and evil
> things to get the NVidia driver to build (it won't pass modpost if the
> kernel is built with lockdep due to the GPL-only exports that get sucked in).
> 
> 
>>I have no idea how NVidia managed to work around that problem, but 
>>VMware modules suddenly depend on this GPL-only symbol, although nothing 
>>in the module sources refers to lockdep (same sources which worked 
>>yesterday are being used).
> 
> It doesn't reference it directly - it gets sucked in via a #define.

VMware code is shoot down due to use of init_waitqueue_head().  It is 
now virtually GPL-only because it is inlined and uses GPL-only function 
lockdep_init_map :-(
						Petr
