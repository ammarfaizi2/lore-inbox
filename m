Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263214AbVCES0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbVCES0U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 13:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263283AbVCES0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 13:26:20 -0500
Received: from orb.pobox.com ([207.8.226.5]:4069 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S263214AbVCES0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:26:05 -0500
In-Reply-To: <42285354.5090900@inode.info>
References: <42283093.7040405@inode.info> <20050304035309.1da7774e.akpm@osdl.org> <42285354.5090900@inode.info>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <93832c6db45c33f7b2f195aae0d469dc@pobox.com>
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
From: Scott Feldman <sfeldma@pobox.com>
Subject: Re: slab corruption in skb allocs
Date: Sat, 5 Mar 2005 10:25:04 -0800
To: Richard Fuchs <richard.fuchs@inode.info>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 4, 2005, at 4:23 AM, Richard Fuchs wrote:
> kernel 2.6.7 doesn't show this behavior, while all kernels from 2.6.9 
> and up do. (i didn't test 2.6.8.x).

Was NAPI turned on for e100 in 2.6.7?  If not, turn NAPI on in the 
2.6.7 driver and see if you get the same result.  If you do, it's very 
likely the bug is in the e100 driver's NAPI implementation.

-scott

