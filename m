Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbUKFTnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbUKFTnR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 14:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUKFTnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 14:43:16 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:14206 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261450AbUKFTnO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 14:43:14 -0500
Date: Sat, 6 Nov 2004 19:42:55 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: shmem_file_setup not exported
In-Reply-To: <yw1xactuojtn.fsf@ford.inprovide.com>
Message-ID: <Pine.LNX.4.44.0411061937370.4000-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Nov 2004, Måns Rullgård wrote:
> I noticed this change in mm/shmem.c:
> 
> -EXPORT_SYMBOL(shmem_file_setup);
> 
> Is there a reason for this, other than nobody using it?

That's the reason hch rightly removed the export, yes.
ipc/shm.c does use it, but it's never a module, so doesn't need export.
No other reason, beyond that it's appropriate to minimize exports.
If you want to use it from your module, just patch the export back.

Hugh

