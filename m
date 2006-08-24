Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030486AbWHXVwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbWHXVwb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030485AbWHXVwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:52:31 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43657 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030288AbWHXVwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:52:30 -0400
Subject: Re: [PATCH 3/7] SLIM main patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mimi Zohar <zohar@us.ibm.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, David Safford <safford@us.ibm.com>,
       kjhall@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Serge E Hallyn <sergeh@us.ibm.com>
In-Reply-To: <OFBA8851BE.520FA69E-ON852571D4.006E9AA6-852571D4.005C4E99@us.ibm.com>
References: <OFBA8851BE.520FA69E-ON852571D4.006E9AA6-852571D4.005C4E99@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 23:13:59 +0100
Message-Id: <1156457640.3007.196.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-24 am 16:41 -0400, ysgrifennodd Mimi Zohar:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote on 08/24/2006 10:15:17 AM:
> revoke_mmap_wperm() walks current->mm->mmap and removes
> the file write permission using do_mprotect().

That is fine for threads of "current" but the pages may be shared
between processes, and there are other fun cases where you can "park"
data in objects and let someone open them later to recover the data (eg
the console)

> We have test shmem and mmap programs in the ltp framework that
> show this actually works.

Cool.
