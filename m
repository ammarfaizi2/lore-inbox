Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWCBAfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWCBAfY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 19:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWCBAfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 19:35:24 -0500
Received: from ozlabs.org ([203.10.76.45]:53204 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751158AbWCBAfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 19:35:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17414.15814.146349.883153@cargo.ozlabs.ibm.com>
Date: Thu, 2 Mar 2006 11:35:18 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Cc: Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Fix powerpc bad_page_fault output  (Re: 2.6.16-rc5-mm1)
In-Reply-To: <20060301164531.GA17755@pb15.lixom.net>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<4404E328.7070807@mbligh.org>
	<20060301164531.GA17755@pb15.lixom.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson writes:

> Seems that the human-readible parts are printed at a differnet printk level
> (well, _at_ a level), so they fell off. Not good.

My understanding was that printk lines without a level are considered
to be at KERN_ERR or so.  Is that wrong?

> Andrew and/or Paulus, see patch below.

It really seems strange to be *removing* printk level tags.  I'd like
to nack this until I understand why it will improve things.  At the
very least it needs a big fat comment so some janitor doesn't come
along and put the tags back in.

Paul.

