Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUBEEXz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 23:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUBEEXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 23:23:55 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:28650 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261464AbUBEEXy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 23:23:54 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 4 Feb 2004 20:23:53 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: dada1 <dada1@cosmosbay.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fs/eventpoll : reduce sizeof(struct epitem)
In-Reply-To: <40210027.4080808@cosmosbay.com>
Message-ID: <Pine.LNX.4.44.0402042022530.5278-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Feb 2004, dada1 wrote:

> Hi Davide
> 
> On a x86_64 platform, I noticed that the size of (struct epitem) is 136 
> bytes, rounded to 192 (because of  L1_CACHE alignment of 64 bytes)
> 
> If you reorder some fields of this structure, we can reduce the size to 
> 128 bytes.
> 
> The rationale is to group nwait & fd integer (32bits) fields, instead of 
> mixing them with pointers (64 bits)

Good catch. Thx I will.



- Davide


