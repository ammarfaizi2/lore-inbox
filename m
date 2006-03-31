Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWCaGGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWCaGGT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 01:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWCaGGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 01:06:19 -0500
Received: from dp.samba.org ([66.70.73.150]:21441 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S1751022AbWCaGGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 01:06:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17452.50912.404106.256236@samba.org>
Date: Fri, 31 Mar 2006 17:06:24 +1100
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] splice support #2
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus and Jens,

Stephen Rothwell just pointed me at the new splice() interface. Looks
really nice!

One comment though. Could we add a off_t to splice to make it more
like pwrite() ? Otherwise threads could get painful with race
conditions between the seek and the splice() call.

Either that or add psplice() like this:

  ssize_t psplice(int fdin, int fdout, size_t len, off_t ofs, unsigned flags);

where ofs sets the offset to read from fdin. 

Cheers, Tridge
