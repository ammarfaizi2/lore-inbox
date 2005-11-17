Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030586AbVKQCpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030586AbVKQCpi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 21:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030587AbVKQCpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 21:45:38 -0500
Received: from ozlabs.org ([203.10.76.45]:41378 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030586AbVKQCpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 21:45:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17275.61128.444101.19949@cargo.ozlabs.ibm.com>
Date: Thu, 17 Nov 2005 13:45:28 +1100
From: Paul Mackerras <paulus@samba.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>,
       Anton Blanchard <anton@samba.org>
Subject: Re: 2.6.15-rc1-git4 build failure on ppc64
In-Reply-To: <1132188084.24066.103.camel@localhost.localdomain>
References: <1132188084.24066.103.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty writes:

> I get following compile error on PPC64 - while trying to compile
> CONFIG_FLATMEM=y. 

You have CONFIG_NUMA=y.  According to Anton, NUMA + FLATMEM is an
invalid combination, but unfortunately the Kconfig doesn't enforce
that at the moment.  That is, if you want CONFIG_FLATMEM=y, you will
have to explicitly set CONFIG_NUMA=n.

Paul.
