Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbVD3Hcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbVD3Hcz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 03:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263139AbVD3Hcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 03:32:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31149 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262545AbVD3Hcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 03:32:51 -0400
Date: Sat, 30 Apr 2005 08:32:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Cc: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
Message-ID: <20050430073238.GA22673@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" <7eggert@gmx.de>,
	Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
References: <3YLdQ-4vS-15@gated-at.bofh.it> <E1DRekV-0001RN-VQ@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DRekV-0001RN-VQ@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2005 at 01:18:19AM +0200, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> 4) Turn umounting own mounts into a non-privileged operation.
> 
> As (AFAI see) the only thing that needs suid privileges is the umount
> operation, and it is granted if the user mounted it himself, you can as
> well do this simple check in the kernel.

Except that we don't have the concept of a mount owner at the VFS level
right now, because everyone is adding stupid suid wrapper hacks instead
of trying to fix the problems for real.

