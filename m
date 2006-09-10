Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWIJQAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWIJQAE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 12:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWIJQAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 12:00:03 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61140 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932269AbWIJQAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 12:00:00 -0400
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part
	3/4: introduce new capabilities
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Madore <david.madore@ens.fr>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
In-Reply-To: <20060910134257.GC12086@clipper.ens.fr>
References: <20060910133759.GA12086@clipper.ens.fr>
	 <20060910134257.GC12086@clipper.ens.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 10 Sep 2006 17:23:13 +0100
Message-Id: <1157905393.23085.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-09-10 am 15:42 +0200, ysgrifennodd David Madore:
> Introduce six new "regular" (=on-by-default) capabilities:
> 
>  * CAP_REG_FORK, CAP_REG_OPEN, CAP_REG_EXEC allow access to the
>    fork(), open() and exec() syscalls,

CAP_REG_EXEC seems meaningless, I can do the same with mmap by hand for
most types of binary execution except setuid (which is separate it
seems)

Given the capability model is accepted as inferior to things like
SELinux policies why do we actually want to fix this anyway. It's
unfortunate we can't discard the existing capabilities model (which has
flaws) as well really.

Alan

