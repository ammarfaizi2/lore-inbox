Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbULFV1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbULFV1d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 16:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbULFV1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 16:27:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:1739 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261657AbULFV13 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 16:27:29 -0500
Date: Mon, 6 Dec 2004 13:27:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Sven =?ISO-8859-1?B?S/ZobGVy?= <skoehler@upb.de>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [BUG] null-pointer deref (perhaps reiserfs3)
Message-Id: <20041206132712.084ac2b3.akpm@osdl.org>
In-Reply-To: <cp2265$pmp$1@sea.gmane.org>
References: <cp02a6$57j$1@sea.gmane.org>
	<cp21l0$mve$1@sea.gmane.org>
	<cp2265$pmp$1@sea.gmane.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Köhler <skoehler@upb.de> wrote:
>
> > dd if=/dev/zero of=image bs=1M count=40
> > mkreiserfs -f image
> > mount -o loop image /mnt/test
> > cp -r /etc/ /mnt/test
> > 
> > The kernel will Oops, and cp will segfault.
> 
> Well, this won't make sense to you, if don't tell you, that "cp -r /etc/ 
> /mnt/test" copies more, than the reiserfs can take. In other words:
> reiserfs crashes if there's no more free diskspace.
> 

Could you please test 2.6.10-rc3?
