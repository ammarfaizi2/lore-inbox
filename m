Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVAOF7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVAOF7V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 00:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVAOF7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 00:59:21 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:3619 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262220AbVAOF7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 00:59:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=MjVMecholSdXIzrdS6XdG/eOspR/Qhu6FBDM4HrS0cfqzp8oV1tuoAIAn0uyXgJJAc5O/OpdvWQU1mJqtUH7hg3MzbHZZc8jHjLO4nFaf+56fHQAfv6sCYXn2krFE9uftkz2UfrbnF0YIchZfMiBBd7PHQRmlTaPbTtuYgfKf90=
Message-ID: <9e4733910501142159c3a13a7@mail.gmail.com>
Date: Sat, 15 Jan 2005 00:59:08 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: chasing the four level page table
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <m1brbrwc89.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105010609175dabc381@mail.gmail.com>
	 <9e4733910501061205354c9508@mail.gmail.com>
	 <20050106214159.GG16373@redhat.com>
	 <9e47339105010721225c0cfb32@mail.gmail.com>
	 <csa0kn$4eg$1@terminus.zytor.com> <m1brbrwc89.fsf@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2005 05:24:54 +0100, Andi Kleen <ak@muc.de> wrote:
> it wants to get at a AGP page outside get_user_pages doesn't work for
> this because the AGP hole is often outside mem_map. For that a
> nice helper is missing.
> 
> I'm not 100% we really want a helper because it's rather obscure
> requirement, unlikely to be useful for others, and it may be better
> to keep it in DRM.

Wouldn't it be better as a helper where the memory management people
maintain it? For example I only work on x86, are there cross platform
issues? Also, the DRM code is missing the page_table_lock around the
calls too.

-- 
Jon Smirl
jonsmirl@gmail.com
