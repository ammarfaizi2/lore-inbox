Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbVAFBy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVAFBy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 20:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbVAFBy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 20:54:56 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:62176 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S262704AbVAFBys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 20:54:48 -0500
Date: Thu, 06 Jan 2005 10:54:47 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Fastboot] Yet another crash dump tool
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org
In-Reply-To: <m1sm5xusxk.fsf@ebiederm.dsl.xmission.com>
References: <20041014074718.26E6.ODA@valinux.co.jp> <m1sm5xusxk.fsf@ebiederm.dsl.xmission.com>
Message-Id: <20050106093723.6C35.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23 Dec 2004 04:59:03 -0700
ebiederm@xmission.com (Eric W. Biederman) wrote:

> developed right now.  Would you be willing to work on the kexec system
> call so we can get a infrastructure that reliably does what is needed
> for everyone? 

We concentrate on the fault analysis. We think the original aim of the
kexec (== fastboot) differ from the caputuring dump. However,
since we apply the effort of the kexec project to mkdump, we are happy
to return something to the kexec project. 

> Reading your documentation it seems to indicate that you have
> successfully avoid using any memory that the crashing kernel used.
> Is that correct?

No. If the code or the data structures running from crash occur to the
mini kernel start (although it is very short) is damaged, starting the 
mini kernel will fail.
What we done (and will do partialy) is that the logical possibility of 
the deadlock/hang condition is eliminated from the code running from 
crash occur to the mini kernel start.

> And just for a little active feedback.  While you safely tuck
> your kernel away in your reserved area of memory it does not appear
> you tuck away the data structures necessary to get there.  Which
> makes me just a little nervous.

What do you mean "the data structures necessary to get there" ?
The necessary information to run the mini kernel and to caputure dump 
is stored in the reserved area at the same time of loading the mini kernel
(during the kernel is normal).

> Eric

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>

