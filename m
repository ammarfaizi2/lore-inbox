Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbUANShT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 13:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbUANShT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 13:37:19 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:38330 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263606AbUANSgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 13:36:41 -0500
Date: Wed, 14 Jan 2004 18:36:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Mark Hounschell <markh@compro.net>
cc: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: VM_AREA size
In-Reply-To: <4005524A.F0A7041C@compro.net>
Message-ID: <Pine.LNX.4.44.0401141827330.1711-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004, Mark Hounschell wrote:
> What would the ramifications be of increasing VM_AREA size in
> include/asm-i386/page.h from 128mb to 256mb. What would be the proper way to
> increase this if the above isn't? 

I think you mean __VMALLOC_RESERVE?  For the most part it's straightforward
to bump it up.  _However_, that breaks boot loader assumptions about where
to load initrd, causing mayhem in that case (and initramfs?).  That's
second hand info: if I'm wrong or out-of-date, Peter is the authority
and will correct me; or try Google VMALLOC_RESERVE boot.

Hugh

