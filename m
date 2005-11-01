Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbVKATah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVKATah (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 14:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVKATah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 14:30:37 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:37320 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1751180AbVKATag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 14:30:36 -0500
Message-ID: <4367C25B.7010300@vc.cvut.cz>
Date: Tue, 01 Nov 2005 20:30:35 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: cs, en
MIME-Version: 1.0
To: nickpiggin@yahoo.com.au
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Nick's core remove PageReserved broke vmware...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nick,
   what's the reason behind disallowing get_user_pages() on VM_RESERVED regions? 
  vmmon uses VM_RESERVED on its 'vma' as otherwise some kernels used by SUSE 
complained loudly about mismatch between PageReserved() and VM_RESERVED flags.

   I'll remove it from vmmon for >= 2.6.14 kernels as that bogus test never made 
to Linux kernel, but I cannot find any reason why get_user_pages() should not 
work on VM_RESERVED (or VM_IO for that matter) user pages.  Can you show me 
reasoning behind that decision ?
							Thanks,
								Petr Vandrovec


b5810039a54e5babf428e9a1e89fc1940fabff11 
 

tree 835836cb527ec9bd525f93eb7e016f3dfb8c8ae2 
 

parent f9c98d0287de42221c624482fd4f8d485c98ab22 
 

author Nick Piggin <nickpiggin@yahoo.com.au> Sat, 29 Oct 2005 18:16:12 -0700 
 

committer Linus Torvalds <torvalds@g5.osdl.org> Sat, 29 Oct 2005 21:40:39 -0700 
 

 
 

     [PATCH] core remove PageReserved 
 

 
 

     Remove PageReserved() calls from core code by tightening VM_RESERVED 
 

     handling in mm/ to cover PageReserved functionality. 
 

 
 


