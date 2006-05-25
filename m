Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbWEYEmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWEYEmb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWEYEmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:42:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35248 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965012AbWEYEma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:42:30 -0400
Date: Wed, 24 May 2006 21:42:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Doug Thompson <norsk5@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6]  EDAC Patch Set
Message-Id: <20060524214203.44cc1adb.akpm@osdl.org>
In-Reply-To: <20060524174303.2323.qmail@web50102.mail.yahoo.com>
References: <20060524174303.2323.qmail@web50102.mail.yahoo.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/edac/e752x_edac.c: In function `e752x_probe1':
drivers/edac/e752x_edac.c:932: warning: `mci' might be used uninitialized in this function
drivers/edac/e752x_edac.c:933: warning: `pvt' might be used uninitialized in this function

And these are indeed both box-killing bugs.  I'm sure you were seeing this
warning as well.

There's this, plus the compile error, plus the ifdef proliferation.  I'll
wait for version 2, thanks.

