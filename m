Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWEJBz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWEJBz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 21:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWEJBz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 21:55:28 -0400
Received: from relay00.pair.com ([209.68.5.9]:48138 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S1751114AbWEJBz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 21:55:27 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: 2.6.17-rc3 -- SMP alternatives: switching to UP code
Date: Tue, 9 May 2006 20:55:01 -0500
User-Agent: KMail/1.9.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <4461341B.7050602@keyaccess.nl>
In-Reply-To: <4461341B.7050602@keyaccess.nl>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605092055.23265.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 May 2006 19:29, Rene Herman wrote:
> Hi list.
>
> I just noticed this in the 2.6.17-rc3 dmesg:
>
> ===
> Checking 'hlt' instruction... OK.
> SMP alternatives: switching to UP code
> Freeing SMP alternatives: 0k freed
> ACPI: setting ELCR to 0400 (from 1608)
> ===
>
> Should I be seeing this "SMP alternatives" thing on a !CONFIG_SMP
> kernel? It does say 0k, but something is apparently being done at
> runtime still. Why?

This is part of a recent patch by Gerd Hoffmann:

>> Implement SMP alternatives, i.e.  switching at runtime between different
>> code versions for UP and SMP.  The code can patch both SMP->UP and UP->SMP.
>> The UP->SMP case is useful for CPU hotplug.

An explicit test of the smp variable (not CONFIG_SMP macro) exists in this 
code. I missed the discussion about this patch, but it appears from reading 
the patch notes that the behavior is intentional. More information can be 
found in the git and lkml archives.

> Rene.

Thanks,
Chase
