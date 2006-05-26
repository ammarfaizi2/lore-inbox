Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWEZSjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWEZSjE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 14:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWEZSjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 14:39:03 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:40125 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751262AbWEZSjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 14:39:01 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>,
       Grant Coady <gcoady.lk@gmail.com>, Chris Wright <chrisw@sous-sol.org>
Subject: Re: [ANNOUNCE] Linux-2.4.32-hf32.5
Date: Sat, 27 May 2006 04:38:58 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <pkie7218hsjc8kqk3hscbv2fk1pbukn726@4ax.com>
References: <20060507131034.GA19198@exosec.fr> <20060525133427.GA22727@w.ods.org> <k2nd725cl0vocvb72boalj06tpjlita644@4ax.com> <20060526121623.GA14474@w.ods.org> <vvvd72p7mv2j9fet19evm807e0flonnugh@4ax.com> <20060526140731.GC14725@w.ods.org>
In-Reply-To: <20060526140731.GC14725@w.ods.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2006 16:07:31 +0200, Willy Tarreau <willy@w.ods.org> wrote:

>[ I removed Jari who told me yesterday he did not need to be Cc'd ]
>
>On Fri, May 26, 2006 at 11:28:51PM +1000, Grant Coady wrote:
>> On Fri, 26 May 2006 14:16:23 +0200, Willy Tarreau <willy@w.ods.org> wrote:
>> 
>> >Could you please pass it through ksymoops so that we get an idea about the
>> >function causing this ? What was the last version not causing it ? hf32.4 ?
>> 
>> Yes, hf32.4 okay, see: <http://bugsplatter.mine.nu/test/linux-2.4/>
>> 
>> >This looks like a structure member gets accessed while a pointer is NULL,
>> >if you always get 0x88... I would be it could come from
>> >2.4.32-ext3-link-unlink-race-1, but that would be strange.
>> 
>> Good guess!  The previous version comment stripped .configs are 
>> linked by machine name from the summary page above.
>
>Hmmm that's bad, this one has been merged into mainline.
>It would look like dentry->d_inode is NULL here :
>
>  double_down(&dir->i_zombie, &dentry->d_inode->i_zombie);

Too late last night for me to realise this, I don't use ext3!  The Oops 
came after all active partitions loaded, 'cos that's when the network 
started (last good dmesg entries before oops).

That might explain why you didn't see this problem your site?

I use ext2 (for small partitions, floppy) and reiserfs 3.6 here, 
they're compiled in and generally dos, vfat, ntfs, iso9660 as 
modules where required. 

Grant.
