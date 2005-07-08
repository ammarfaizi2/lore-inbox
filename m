Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262750AbVGHSVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbVGHSVY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 14:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbVGHSVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 14:21:24 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:63149 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262750AbVGHSVX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 14:21:23 -0400
References: <OFB01287B5.D35EDB80-ON88257038.005DEE97-88257038.005EDB8B@us.ibm.com>
In-Reply-To: <OFB01287B5.D35EDB80-ON88257038.005DEE97-88257038.005EDB8B@us.ibm.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Bryan Henderson <hbryan@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxram@us.ibm.com, mike@waychison.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: share/private/slave a subtree - define vs enum
Date: Fri, 08 Jul 2005 21:21:22 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42CEC422.00001C6C@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel writes:
> > If it's really enumerated data types, that's fine, but this example was 
> > about bitfield masks.

Bryan Henderson writes:
> Ah.  In that case, enum is a pretty tortured way to declare it, though it 
> does have the practical advantages over define that have been mentioned 
> because the syntax is more rigorous.

I think the bit we're talking about is this: 

> Index: 2.6.12/fs/pnode.c
> ===================================================================
> --- /dev/null
> +++ 2.6.12/fs/pnode.c
> @@ -0,0 +1,362 @@
> +
> +#define PNODE_MEMBER_VFS  0x01
> +#define PNODE_SLAVE_VFS   0x02

I don't see how the following is tortured: 

enum {
       PNODE_MEMBER_VFS  = 0x01,
       PNODE_SLAVE_VFS   = 0x02
}; 

In fact, I think it is more natural. An almost identical example even 
appears in K&R. 

                           Pekka 

