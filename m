Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbUK3GyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbUK3GyS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 01:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUK3GyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 01:54:18 -0500
Received: from 209-128-68-124.bayarea.net ([209.128.68.124]:32197 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261983AbUK3GyM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 01:54:12 -0500
Message-ID: <41AC1885.1040301@zytor.com>
Date: Tue, 30 Nov 2004 06:51:49 +0000
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Mariusz Mazur <mmazur@kernel.pl>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <20041130014328.GA14337@bougret.hpl.hp.com> <Pine.LNX.4.58.0411292019500.22796@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411292019500.22796@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 29 Nov 2004, Jean Tourrilhes wrote:
> 
>>	So, which kernel ABI should be present on my system in
>>/usr/include/linux and /usr/include/asm ? Should I use the ABI from
>>2.6.X, 2.4.X or 2.2.X ?
> 
> 
> I have always felt (pretty strongly) that the /usr/include/xxx contents 
> should not be kernel-dependent, but be linked to your glibc version. 
> That's why the symlink from /usr/include/xxx to /usr/src/linux/include/
> has been deprecated for the last, oh about ten years now..
> 
> Yes, there are some _very_ specific things which might care about system 
> calls or ioctl's that have been added later, but let's face it, we don't 
> actually do that very often. The kernel may change at a rapid pace, but 
> user interfaces don't, and user interfaces that would bypass the C library 
> change even less frequently.
> 

More to the point, though, is that they should be supersets of each 
other, which means you should be able to upgrade them to the latest version.

Most of the ABI changes, after all, are new structures needed for 
various things.

	-hpa

