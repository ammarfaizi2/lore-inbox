Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVKFPEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVKFPEv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 10:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbVKFPEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 10:04:51 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:45235 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S932067AbVKFPEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 10:04:50 -0500
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vbetool, mm kernels and mmap
In-Reply-To: <20051106145252.GB881@gamma.logic.tuwien.ac.at>
References: <20051106145252.GB881@gamma.logic.tuwien.ac.at>
Date: Sun, 6 Nov 2005 15:04:44 +0000
Message-Id: <E1EYm4a-0004Bc-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> wrote:
> Hi all!
> 
> Playing around with suspend 2 ram I have to use vbetool.
> Using kernel 2.6.14-rc4-mm1 (and probably earlier) I get:
> 
> program vbetool is using MAP_PRIVATE, PROT_WRITE mmap of VM_RESERVED
> memory, which is deprecated. Please report this to linux-kernel@vger.kernel.org

It's actually coming from lrmi rather than vbetool itself. lrmi seems to
use it to set up a set of memory to mimic the <1MB space, and again to
actually gain access to low memory. Is there documentation about this
deprecation anywhere? 

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
