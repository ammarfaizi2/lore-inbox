Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUJRLDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUJRLDI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 07:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUJRLDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 07:03:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:24713 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266128AbUJRLDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 07:03:06 -0400
Subject: Re: [PATCH] allow kernel compile with native ppc64 compiler
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041018075433.GA24927@suse.de>
References: <20041017185557.GA9619@suse.de>
	 <16754.59442.992185.715900@cargo.ozlabs.ibm.com>
	 <20041018045603.GA8500@suse.de>
	 <16755.23272.754150.209624@cargo.ozlabs.ibm.com>
	 <20041018075433.GA24927@suse.de>
Content-Type: text/plain
Message-Id: <1098097106.30570.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 18 Oct 2004 20:58:27 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 17:54, Olaf Hering wrote:

> 
> > Ben H suggested making the default BOOTCC be $(CC) -m32, which makes
> > sense to me.

How so ? The idea is to add -m32 to whatever compiler you are using for
the rest of the kernel (assuming bi-arch) which is a lot more sane than
using whatever _local_ compiler you are using _and_ assuming bi-arch...

Of course, that would only be the "defaul", with the ability of explicitly
passing CROSS32_COMPILE to make...

Ben.


