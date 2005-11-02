Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVKBCqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVKBCqH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 21:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVKBCqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 21:46:07 -0500
Received: from ozlabs.org ([203.10.76.45]:26599 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932227AbVKBCqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 21:46:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17256.10342.228209.745529@cargo.ozlabs.ibm.com>
Date: Wed, 2 Nov 2005 13:45:58 +1100
From: Paul Mackerras <paulus@samba.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc bug.h namespace pollution
In-Reply-To: <20051101151716.GY7992@ftp.linux.org.uk>
References: <20051101151716.GY7992@ftp.linux.org.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro writes:

> 	DATA_TYPE is really not a good thing to put into header that
> gets included all over the tree...

Very true.  However, I don't see any reason why the cast shouldn't
just be (long) on both 32-bit and 64-bit, so we can get rid of that
define altogether.

Paul.
