Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264099AbTIBUfh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 16:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTIBUfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 16:35:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:57231 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261482AbTIBUc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 16:32:58 -0400
Date: Tue, 2 Sep 2003 13:15:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: hugh@veritas.com, rusty@rustcorp.com.au, mingo@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-Id: <20030902131537.53d02113.akpm@osdl.org>
In-Reply-To: <20030902195427.GA15262@mail.jlokier.co.uk>
References: <20030902065144.GC7619@mail.jlokier.co.uk>
	<Pine.LNX.4.44.0309021626540.1542-100000@localhost.localdomain>
	<20030902195427.GA15262@mail.jlokier.co.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> wrote:
>
> 	3. For (vma & VM_SHARED), look up futex_qs keyed on
> 	   (vma->vm_file, vma->vm_pgoff + (uaddr - vma->vm_start) >>
> 	   PAGE_SHIFT, offset).

That's a bit meaningless in non-linear mappings.

