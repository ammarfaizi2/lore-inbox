Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269296AbUJQVqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269296AbUJQVqh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 17:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269299AbUJQVqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 17:46:37 -0400
Received: from ozlabs.org ([203.10.76.45]:34257 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269296AbUJQVqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 17:46:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16754.59442.992185.715900@cargo.ozlabs.ibm.com>
Date: Mon, 18 Oct 2004 07:46:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>
Cc: linuxppc64-dev@ozlabs.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow kernel compile with native ppc64 compiler
In-Reply-To: <20041017185557.GA9619@suse.de>
References: <20041017185557.GA9619@suse.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering writes:

> The zImage is a 32bit binary, but a native powerpc64-linux gcc will
> produce 64bit objects in arch/ppc64/boot.
> This patch fixes it.

... and breaks the compile on older toolchains that don't understand
-m32.  We need to make the -m32 conditional on HAS_BIARCH as defined
in arch/ppc64/Makefile.

Paul.
