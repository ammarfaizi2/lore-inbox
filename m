Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbUANS6F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 13:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbUANS6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 13:58:05 -0500
Received: from terminus.zytor.com ([63.209.29.3]:43446 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262805AbUANS6C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 13:58:02 -0500
Message-ID: <4005912F.9020008@zytor.com>
Date: Wed, 14 Jan 2004 10:57:51 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Mark Hounschell <markh@compro.net>, linux-kernel@vger.kernel.org
Subject: Re: VM_AREA size
References: <Pine.LNX.4.44.0401141827330.1711-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0401141827330.1711-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Wed, 14 Jan 2004, Mark Hounschell wrote:
> 
>>What would the ramifications be of increasing VM_AREA size in
>>include/asm-i386/page.h from 128mb to 256mb. What would be the proper way to
>>increase this if the above isn't? 
> 
> I think you mean __VMALLOC_RESERVE?  For the most part it's straightforward
> to bump it up.  _However_, that breaks boot loader assumptions about where
> to load initrd, causing mayhem in that case (and initramfs?).  That's
> second hand info: if I'm wrong or out-of-date, Peter is the authority
> and will correct me; or try Google VMALLOC_RESERVE boot.
> 

I think it affects initramfs too.

It only affects boot loaders which don't support version 2.03 of the 
boot protocol; unfortunately that includes GRUB last I checked.

We really need a better dialog with the GRUB people, unfortunately at 
least I have unsuccessful in starting such a dialog.

GRUB, in particular, needs to report the boot loader ID they're using, 
plus support version 2.03 of the protocol.

	-hpa

