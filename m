Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268504AbUH3Phz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268504AbUH3Phz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 11:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268505AbUH3Phy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 11:37:54 -0400
Received: from the-village.bc.nu ([81.2.110.252]:15234 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268503AbUH3Phi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 11:37:38 -0400
Subject: Re: [PATCH] Allow cluster-wide flock
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ken Preslan <kpreslan@redhat.com>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040830151945.GA16894@potassium.msp.redhat.com>
References: <20040830151945.GA16894@potassium.msp.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093876517.30190.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 30 Aug 2004 15:35:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-30 at 16:19, Ken Preslan wrote:
> Hi,
> 
> Below is a patch that lets a cluster filesystem (such as GFS) implement
> flock across a the cluster.  Please apply.

flock affects local node only traditionally and applications expect high
performance from it. Our documentation merely says

       flock(2) does not lock files over NFS.  Use fcntl(2) instead:
that does
       work  over  NFS,  given  a  sufficiently  recent version of Linux
and a
       server which supports locking.

I'm not sure how we should count GFS but other than noting a need to
think about it I see no problems with a cluster being "local"

