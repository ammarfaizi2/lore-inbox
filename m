Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVEBJPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVEBJPd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 05:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVEBJPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 05:15:32 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:21443 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261158AbVEBJP2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 05:15:28 -0400
Date: Mon, 2 May 2005 11:15:24 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
       Matthew Wilcox <matthew@wil.cx>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: fcntl: F_SETLEASE/F_RDLCK question
Message-ID: <20050502091524.GA6457@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the semantics of fnctl used together with F_SETLEASE and
argument F_RDLCK have been changed with bk changeset
1.1938.185.141 (sometime between 2.6.9 and 2.6.10).
Since then it's only possible to get a read lease when the
file in question does not have _any_ writers.
This is at least inconsistent with the man page of fcntl
and looks pretty much like this is a bug in the kernel.

Any comments?

Thanks,
Heiko
