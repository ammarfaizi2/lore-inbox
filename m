Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWEYCme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWEYCme (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 22:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWEYCme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 22:42:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:919 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964828AbWEYCme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 22:42:34 -0400
To: Magnus Damm <magnus@valinux.co.jp>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Fastboot] [PATCH 01/03] kexec: Avoid overwriting the current
 pgd (V2, stubs)
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	<20060524044237.14219.15615.sendpatchset@cherry.local>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 24 May 2006 20:41:36 -0600
In-Reply-To: <20060524044237.14219.15615.sendpatchset@cherry.local> (Magnus
 Damm's message of "Wed, 24 May 2006 13:40:36 +0900 (JST)")
Message-ID: <m1wtcasu5b.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <magnus@valinux.co.jp> writes:

> --===============059810052910035161==
>
> kexec: Avoid overwriting the current pgd (V2, stubs)
>
> This patch adds an architecture specific structure "struct kimage_arch" to 
> struct kimage. This structure is filled in with members by the architecture
> specific patches followed by this one.

You should be able to completely remove the need for this by simply
adding a single additional external variable to the control code
page.  Given that you abuse this information and store way more
than you need I am not persuaded that it is an interesting case.

Eric
