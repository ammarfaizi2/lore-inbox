Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263950AbUDNIRO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 04:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUDNIRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 04:17:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:32658 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263950AbUDNIRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 04:17:14 -0400
Date: Wed, 14 Apr 2004 01:16:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] conditionalize some boring buffer_head checks
Message-Id: <20040414011653.22c690d9.akpm@osdl.org>
In-Reply-To: <407CF201.408@pobox.com>
References: <407CEB91.1080503@pobox.com>
	<20040414005832.083de325.akpm@osdl.org>
	<20040414010240.0e9f4115.akpm@osdl.org>
	<407CF201.408@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> I would rather not kill the code in submit_bh() outright, just disable 
>  it for non-filesystem developers.

submit_bh() is a slowpath ;) The one in mark_buffer_dirty() will be called
more often, possibly others.  Kill!

