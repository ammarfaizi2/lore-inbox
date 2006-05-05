Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWEEF5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWEEF5D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 01:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWEEF5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 01:57:03 -0400
Received: from ozlabs.org ([203.10.76.45]:32743 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932474AbWEEF5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 01:57:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17498.59681.133131.336680@cargo.ozlabs.ibm.com>
Date: Fri, 5 May 2006 15:56:49 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH 07/13] powerpc: export symbols for page size selection
In-Reply-To: <20060429233921.099214000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain>
	<20060429233921.099214000@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann writes:

> We need access to some symbols in powerpc memory management
> from spufs in order to create proper SLB entries.

I don't like exporting low-level implementation details like this, and
it seems a bit bogus to have an SLB miss handler in a module.  Could
you move the SLB miss handler to the non-modular part?

Regards,
Paul.
