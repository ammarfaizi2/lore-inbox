Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbUKBXQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbUKBXQh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbUKBXO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:14:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18910 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262614AbUKBXLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:11:08 -0500
Date: Tue, 2 Nov 2004 15:10:44 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: linux-kernel@vger.kernel.org, cs@tequila.co.jp, zaitcev@redhat.com
Subject: Re: Test patch for ub and double registration
Message-ID: <20041102151044.4270bc12@lembas.zaitcev.lan>
In-Reply-To: <200411022257.24752.cova@ferrara.linux.it>
References: <20041101164432.3fa72b81@lembas.zaitcev.lan>
	<200411022257.24752.cova@ferrara.linux.it>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Nov 2004 22:57:24 +0100, Fabio Coatti <cova@ferrara.linux.it> wrote:

Dear Fabio, thank you for the test. Indeed, this is wrong:

> i.e. no lines like
> 
> uba: device 4 capacity nsec 1024000 bsize 512
> uba: uba1

Previously, it would retry capacity reading, quite by accident: the block
level did revalidation several times when faced with unexpected responses
from ub. The last one succeeded.

I'd like to secure one last favour from you. Please do this for me:
1. Connect the thing
2. Run
find /sys -name diag | xargs cat | mail -s "Flavio's ub diag" zaitcev@redhat.com

Thanks a lot,
-- Pete
