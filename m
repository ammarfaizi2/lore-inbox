Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268149AbUIKMwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268149AbUIKMwR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 08:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268148AbUIKMwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 08:52:17 -0400
Received: from legaleagle.de ([217.160.128.82]:36998 "EHLO www.legaleagle.de")
	by vger.kernel.org with ESMTP id S268146AbUIKMwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 08:52:04 -0400
Message-ID: <4142F4CC.7080708@trash.net>
Date: Sat, 11 Sep 2004 14:51:24 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: [PATCH 2.6 NETFILTER] new netfilter module ipt_program.c
References: <20040911124106.GD24787@lkcl.net>
In-Reply-To: <20040911124106.GD24787@lkcl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Kenneth Casson Leighton wrote:
> decided to put this into a separate module.  based on ipt_owner.c.
> does full program's pathname.  like ipt_owner, only suitable for
> outgoing connections.

I agree that it would be useful to match the full path, but
the patch is broken, as are the owner match's pid-, sid- and
command-matching options. You can't grab files->file_lock
outside of process context. Besides, we want to consolidate
functionality, not add new matches that do basically the same
as existing ones.

Regards
Patrick
