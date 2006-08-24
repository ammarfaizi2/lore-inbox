Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422776AbWHXXJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422776AbWHXXJQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 19:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422777AbWHXXJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 19:09:16 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:30371 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1422776AbWHXXJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 19:09:15 -0400
Message-ID: <44EE319A.3000803@vmware.com>
Date: Thu, 24 Aug 2006 16:09:14 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Remove default_ldt, and simplify ldt-setting.
References: <44EE308B.8000304@goop.org>
In-Reply-To: <44EE308B.8000304@goop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> (This is the replacement for kill-default_ldt.patch.)
>
> Remove default_ldt, and simplify ldt-setting.
>
> This patch removes the default_ldt[] array, as it has been unused
> since iBCS stopped being supported.  This means it is now possible to
> actually set an empty LDT segment.
>
> In order to deal with this, the set_ldt_desc/load_LDT pair has been
> replaced with a single set_ldt() operation which is responsible for
> both setting up the LDT descriptor in the GDT, and reloading the LDT
> register.  If there are no LDT entries, the LDT register is loaded
> with a NULL descriptor.
>
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> Cc: Andi Kleen <ak@suse.de>
> Cc: Zachary Amsden <zach@vmware.com>

Acked-by: Zachary Amsden <zach@vmware.com>

This looks good.

Zach
