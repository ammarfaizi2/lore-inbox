Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUEGLPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUEGLPK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 07:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUEGLPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 07:15:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:50654 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263225AbUEGLPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 07:15:06 -0400
Date: Fri, 7 May 2004 04:14:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steve Young <sdyoung@vt220.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] change pts allocation behaviour in
Message-Id: <20040507041442.7e67c15e.akpm@osdl.org>
In-Reply-To: <20040507084242.GA11389@eviltron.local.lan>
References: <20040507084242.GA11389@eviltron.local.lan>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Young <sdyoung@vt220.org> wrote:
>
>   Here is a patch to change the way ptses are allocated.  It applies against
>  2.6.6-rc3.  Basically it tries to humour old glibc by always obtaining a pts
>  in the range of 0-255 first.  However, if that fails, then it will search the
>  higher ranges. 

Wouldn't we be better off with plain old first-fit-from-zero?
