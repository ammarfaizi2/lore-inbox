Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266014AbUGAQb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUGAQb6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 12:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266027AbUGAQb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 12:31:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:56319 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266014AbUGAQb4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 12:31:56 -0400
Date: Thu, 1 Jul 2004 11:31:16 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linas@austin.ibm.com, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64: lockfix for rtas error log
Message-Id: <20040701113116.72a25ed0.moilanen@austin.ibm.com>
In-Reply-To: <16611.18350.530425.178652@cargo.ozlabs.ibm.com>
References: <20040629175007.P21634@forte.austin.ibm.com>
	<16610.41869.78636.349800@cargo.ozlabs.ibm.com>
	<20040630125027.T21634@forte.austin.ibm.com>
	<16611.18350.530425.178652@cargo.ozlabs.ibm.com>
Organization: LTC
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As far as I can see, the ameslab tree has _never_ contained those
> lines.  The last change to chrp_setup.c was on 1 May 2004, and neither
> that version nor any of the earlier versions that I looked at have
> those lines.  Are you sure you don't have that as a local change in
> your copy?  Do a bk sfiles -i and a bk push -n and see if it shows up.

Back on May 6th, Nathan Fontenot posted a patch to linuxppc64, that had
this fixed when he noticed it got removed.  It looks like the patch was
never merged.
 
> As for the RTAS messages being printk'd, the only possible
> justification would be if there was a userspace tool to analyse them.
> I don't know if such a thing exists, and if it does, I certainly don't
> have a copy.  Is anyone working on that?

I pushed a patch to remove the log_error messages from going to the
console by default.  The error logs still should be put in
/proc/ppc64/rtas/error_log for rtas_errd to pick them up and send it to
ELA for decode.  These apps are already done and can be found on IBM's
diagnostic service website.

http://techsupport.services.ibm.com/server/lopdiags/suselinux/pseries

Thanks,
Jake
