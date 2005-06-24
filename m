Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263224AbVFXJi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263224AbVFXJi6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 05:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbVFXJi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 05:38:57 -0400
Received: from web51301.mail.yahoo.com ([206.190.38.167]:62542 "HELO
	web51301.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263224AbVFXJfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 05:35:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4jlyhOikLKameEU8daXaOJ7/arLbGFGRlmgNfxZXetPRMM6c4gD+j6H2xQti5rKYNlbZiImt1MCIHPBvMeaDETc9aOiD9luZHdYgJX3nI7YxqOyk41Gm2twNr1SA8RIqe00NU0KOEtnuv6lBE89q7Hz6NQDukrXUEhT3aSGIPgE=  ;
Message-ID: <20050624093510.4330.qmail@web51301.mail.yahoo.com>
Date: Fri, 24 Jun 2005 02:35:10 -0700 (PDT)
From: Timothy Webster <tdwebste2@yahoo.com>
Reply-To: tdwebste2@yahoo.com
Subject: Re: reiser4 plugins
To: Lincoln Dale <ltd@cisco.com>, Hans Reiser <reiser@namesys.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <42BBB1FA.7070400@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Lincoln Dale <ltd@cisco.com> wrote:
snip

> 
> Nikita basically said as much in Message-ID: 
> <17081.30107.751071.983835@gargle.gargle.HOWL>
> earlier in this thread:
>     "But it is not so. There _are_
> plugins-in-the-VFS. VFS operates on 
> opaque
>      objects (inodes, dentries, file system types)
> through interfaces:
>     
> {inode,address_space,dentry,sb,etc.}_operations.
> Every file system
>      back-end if free to implement whatever number
> of these interfaces. And
>      the do this already: check the sources; even
> ext2 does this: e.g.,
>      ext2_fast_symlink_inode_operations and
> ext2_symlink_inode_operations.
> 
>      This is exactly what upper level reiser4
> plugins are for.
> 
>      I guess that one of Christoph Hellwig's
> complaints is that reiser4
>      introduces another layer of abstraction to
> implement something that
>      already exists."


What reiserfs4 brings is file based plugins. Which is
extremely useful and powerful. I don't want to see
this go away.

I think it is the task of the linux community to
generalize the vfs layer and not lock out reiserfs4
until that is done. reiserfs4 wants to keep a plugin
id for each and every file. An additional filesystem
layer is the traditional solution to achieve advanced
features, but not an optimal solution in my opinion.
Yes gnome, kde and perhaps cifs do it. But if instead
they used file plugins a lot more could be shared.

Blush, I am not a file system expert

-Tim

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
