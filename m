Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbTENFCR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 01:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbTENFCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 01:02:17 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7508 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S261174AbTENFCQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 01:02:16 -0400
To: Andy Pfiffer <andyp@osdl.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [KEXEC][2.5.69] Re: Updated kexec diffs...
References: <3EBA626E.6040205@cyberone.com.au>
	<20030508121211.532dcbcf.akpm@digeo.com>
	<3EBC37C4.9090602@cyberone.com.au>
	<20030509162911.2cd5321e.akpm@digeo.com>
	<m1u1c37d2o.fsf@frodo.biederman.org>
	<20030509201327.734caf9e.akpm@digeo.com>
	<m1of2978ao.fsf@frodo.biederman.org>
	<20030511121753.7a883afb.akpm@digeo.com>
	<m1fznl57ss.fsf_-_@frodo.biederman.org>
	<1052861167.1324.15.camel@andyp.pdx.osdl.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 May 2003 23:11:33 -0600
In-Reply-To: <1052861167.1324.15.camel@andyp.pdx.osdl.net>
Message-ID: <m1k7cu3yey.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> On Sun, 2003-05-11 at 17:26, Eric W. Biederman wrote:
> > This is my next round of kexec inspired kernel patches.
> > 
> > kexec seems good at reproducing what are otherwise almost
> > inaccessible corner cases in the kernel reboot/initialization code paths.
> > 
> > Also available at:
> > http://www.xmission.com/~ebiederm/files/kexec/
> 
> Eric,
> 
> Good news: I have tried your patchset on a 2-way system, and kexec
> worked.
> 
> Mixed news: I didn't get any console output after the last printk in
> kexec ("Starting new kernel"), nor did I get any console output during
> the reboot.  Other than that, the system rebooted fine and went
> multi-user (complete with graphical login and networking).  Strange.

Very strange as nothing fundamental changed.  

The only thing I did was inline use_mm into kexec piece.  And
to make the cpu shutdown code safe from an interrupt context.

> I've got two other systems to test this on, and I'll report when I have
> results. I have attached my .config and lspci output for the system I
> used.
> 
> I have also loaded your patch set into OSDL's on-line patch manager. 
> The patch stack I used can be found here:
> 
> APIC changes:
> http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1842
> 
> i8259 changes:
> http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1843
> 
> reboot on BSP:
> http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1844
> 
> hwfixes & x86kexec:
> http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1845
> 
> For the lazy among us, I have also uploaded a combined patch for 2.5.69
> that includes the four previous patches in one:
> http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1846

And Andrew has it in 2.5.69-mm4 and is busy pestering me about compile
errors.  There needs to be an updated version where all of the
appropriate functions have the noreturn attribute.  Hopefully
I can do a thorough job this weekend, and create some updated patches.

Eric

