Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267004AbTGLDXU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 23:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267332AbTGLDXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 23:23:20 -0400
Received: from air-2.osdl.org ([65.172.181.6]:50602 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267004AbTGLDXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 23:23:20 -0400
Date: Fri, 11 Jul 2003 20:38:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: jcwren@jcwren.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in open() function (?)
Message-Id: <20030711203809.3c320823.akpm@osdl.org>
In-Reply-To: <200307112309.08542.jcwren@jcwren.com>
References: <20030712011716.GB4694@bouh.unh.edu>
	<16143.25800.785348.314274@cargo.ozlabs.ibm.com>
	<20030712024216.GA399@bouh.unh.edu>
	<200307112309.08542.jcwren@jcwren.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.C. Wren" <jcwren@jcwren.com> wrote:
>
> I was playing around today and found that if an existing file is opened with 
>  O_TRUNC | O_RDONLY, the existing file is truncated.

Well that's fairly idiotic, isn't it?

The Open Group go on to say "The result of using O_TRUNC with O_RDONLY is
undefined" which is also rather silly.

I'd be inclined to leave it as-is, really.
