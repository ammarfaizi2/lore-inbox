Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268698AbUJPLaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268698AbUJPLaP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 07:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268700AbUJPLaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 07:30:15 -0400
Received: from puzzle.sasl.smtp.pobox.com ([207.8.226.4]:11137 "EHLO
	sasl.smtp.pobox.com") by vger.kernel.org with ESMTP id S268698AbUJPLaK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 07:30:10 -0400
Date: Sat, 16 Oct 2004 04:30:07 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.28-pre4
Message-ID: <20041016113007.GA22527@ip68-4-98-123.oc.oc.cox.net>
References: <20041008112135.GG16028@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041008112135.GG16028@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 08:21:35AM -0300, Marcelo Tosatti wrote:
> From now on can now change only what is necessary and let 
> the 2.4 tree in peace :)

Is it still possible to add this patch to 2.4 (i.e. 2.4.28 or 2.4.29),
or is it too late/too invasive?

[PATCH] fix ELF exec with huge bss
http://linux.bkbits.net:8080/linux-2.5/cset@3ff112802L-9-rs0BbkozDnTnpch9w

AFAIK, this patch has been in 2.6 for several months and has been in Red
Hat Enterprise Linux 3 kernels for a long while too. The reason I'd like
to see it in a future 2.4 kernel is that it fixes some crashes that some
of my users are seeing (e.g. with a Fortran 77 program that has a BSS
larger than 2GB).


BTW, if the above patch is added to 2.4, maybe this patch is also needed
to handle a corner case (like the previous patch, it's been in 2.6 for
several months and RHEL 3 for a long time):

[PATCH] binfmt_elf.c fix for 32-bit apps with large bss
http://linux.bkbits.net:8080/linux-2.5/cset@407afc8e4kEZSl4pklf3Ptrl2ZzkeA

-Barry K. Nathan <barryn@pobox.com>

