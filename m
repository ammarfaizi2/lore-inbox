Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268476AbUHTSrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268476AbUHTSrs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUHTSrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:47:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:46798 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268476AbUHTSrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:47:05 -0400
Date: Fri, 20 Aug 2004 11:45:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: vherva@viasys.com
Cc: petr@vandrovec.name, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: 2.6.8.1-mm2 breaks vmware
Message-Id: <20040820114518.49a65b69.akpm@osdl.org>
In-Reply-To: <20040820151621.GJ23741@viasys.com>
References: <20040820104230.GH23741@viasys.com>
	<20040820035142.3bcdb1cb.akpm@osdl.org>
	<20040820131825.GI23741@viasys.com>
	<20040820144304.GF8307@viasys.com>
	<20040820151621.GJ23741@viasys.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva <vherva@viasys.com> wrote:
>
>  On Fri, Aug 20, 2004 at 05:43:04PM +0300, you [Ville Herva] wrote:
>  > On Fri, Aug 20, 2004 at 04:18:25PM +0300, you [Ville Herva] wrote:
>  > > 
>  > > I just noticed I had missed get_user_pages-handle-VM_IO.patch - I'll try
>  > > backing that out first. I'll report back if I find anything interesting 
>  > > with different patch mixtures.
>  > 
>  > Well, I just tried 2.6.8.1-mm2 minus get_user_pages-handle-VM_IO.patch but
>  > that didn't help with the "cannot allocate memory" problem. Curiously, I
>  > didn't get the "get_user_pages() returns -EFAULT" warning with this kernel.
>  > 
>  > I just put get_user_pages-handle-VM_IO.patch back and reverted
>  > dev-mem-restriction-patch.patch - I'll report back when it has compiled. 
> 
>  Ok, 2.6.8.1-mm2 minus dev-mem-restriction-patch.patch fixes the "cannot
>  allocate memory" problem. 

Thanks for working that out.

Strange.  I'd have assumed that the Fedora kernels include that patch.

>  With this kernel I still get the 
> 
>  --8<-----------------------------------------------------------------------
>  vmmon: Your kernel is br0ken. get_user_pages(current, current->mm, b7dd1000, 1, 1, 0, &page, NULL) returned -14.
>  vmmon: I'll try accessing page tables directly, but you should know that your
>  vmmon: kernel is br0ken and you should uninstall all additional patches you vmmon: have installed!
>  vmmon: FYI, copy_from_user(b7dd1000) returns 0 (if not 0 maybe your kernel is not br0ken)
>  --8<-----------------------------------------------------------------------
> 
>  warning, but vmware appears to work now (well apart from altgr not working,
>  but that has been broken since 2.4 -> 2.6 transition.)
> 
>  I'm still not 100% which of the patches causes that get_user_pages()
>  warning.

If you could work that out sometime, it would help.
