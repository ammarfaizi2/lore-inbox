Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVLUMoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVLUMoy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 07:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVLUMoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 07:44:54 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:32482 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S932401AbVLUMox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 07:44:53 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Date: Wed, 21 Dec 2005 07:44:51 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net> <43A91C57.20102@cosmosbay.com>
In-Reply-To: <43A91C57.20102@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512210744.52559.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 December 2005 04:11, Eric Dumazet wrote:
> (x86_64 : PAGE_SIZE = 4096, L1_CACHE_BYTES = 64)
> 
> On my machines, I can say that the 32 and 192 sizes could be avoided in favor 
> in spending less cpu cycles in __find_general_cachep()
> 
> Could some of you post the result of the following command on your machines :
> 
> # grep "size-" /proc/slabinfo |grep -v DMA|cut -c1-40
size-131072            0      0 131072
size-65536             3      3  65536
size-32768             0      0  32768
size-16384             3      3  16384
size-8192             28     28   8192
size-4096            184    184   4096
size-2048            272    272   2048
size-1024            300    300   1024
size-512             275    376    512
size-256             717    720    256
size-192            1120   1220    192
size-64             7720   8568     64
size-128           45019  65830    128
size-32             1627   3333     32

amd64 up 

Ed Tomlinson
