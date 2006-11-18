Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753569AbWKRAVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbWKRAVE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756098AbWKRAVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:21:03 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19139 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1753561AbWKRAVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:21:00 -0500
Date: Sat, 18 Nov 2006 01:20:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, rjw@sisk.pl
Subject: Re: [PATCH 13/20] x86_64: 64bit PIC ACPI wakeup trampoline
Message-ID: <20061118002041.GE9188@elf.ucw.cz>
References: <20061117223432.GA15449@in.ibm.com> <20061117225103.GN15449@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117225103.GN15449@in.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-11-17 17:51:03, Vivek Goyal wrote:
> 
> 
> o Moved wakeup_level4_pgt into the wakeup routine so we can
>   run the kernel above 4G.
> 
> o Now we first go to 64bit mode and continue to run from trampoline and
>   then then start accessing kernel symbols and restore processor context.
>   This enables us to resume even in relocatable kernel context when 
>   kernel might not be loaded at physical addr it has been compiled for.
> 
> o Removed the need for modifying any existing kernel page table.
> 
> o Increased the size of the wakeup routine to 8K. This is required as
>   wake page tables are on trampoline itself and they got to be at 4K
>   boundary, hence one page is not sufficient.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>

Looks okay to me, ACK.
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
