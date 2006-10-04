Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030521AbWJDAXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030521AbWJDAXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030522AbWJDAXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:23:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36535 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030521AbWJDAXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:23:42 -0400
Subject: RE: System hang problem.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manish Neema <Manish.Neema@synopsys.com>
Cc: Keith Mannthey <kmannth@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <C9A861D62D068643A0F4A7B1BCB38E2C0327B5FE@US01WEMBX1.internal.synopsys.com>
References: <C9A861D62D068643A0F4A7B1BCB38E2C0327B5FE@US01WEMBX1.internal.synopsys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 01:49:14 +0100
Message-Id: <1159922954.17553.141.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-03 am 17:07 -0700, ysgrifennodd Manish Neema:
> Thanks Keith for the response.
> 
> My explanation earlier is not clear. The "automount" process dying with
> restrictive overcommit settings is not because of the OOM kill. It looks
> like some bug with "automount" binary itself causing it to exit when it
> could not service a new request.
> 
> "cd /remote/something" when the system is out of (allocate'able) memory
> causes the below events (obtained from /var/log/messages)
> 
> Oct  3 13:35:32 gentoo036 automount[2060]: handle_packet_missing: fork:
> Cannot allocate memory
> Oct  3 13:35:34 gentoo036 automount[2060]: can't unmount /remote

Your kernel is behaving correctly if it does this in mode 2. You need
more memory or to better set resource limits on what is running. 

Alan

