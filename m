Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWEDG6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWEDG6F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 02:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWEDG6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 02:58:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35050 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751417AbWEDG6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 02:58:03 -0400
Subject: Re: limits / PIPE_BUF?
From: Arjan van de Ven <arjan@infradead.org>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0605032244230.25908@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0605032244230.25908@shell2.speakeasy.net>
Content-Type: text/plain
Date: Thu, 04 May 2006 08:58:01 +0200
Message-Id: <1146725882.3101.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 22:55 -0700, Vadim Lobanov wrote:
> Hi,
> 
> I was reading through the include/linux/limits.h file in order to
> generate a cleanup patch for it -- a large number of #defines within
> that file are no longer being used, as I surmise that they are simply
> remnants of earlier implementations.
> 
> A snippet from include/linux/limits.h:
> #define PIPE_BUF        4096    /* # bytes in atomic write to a pipe */
> 
> PIPE_BUF is a bit of an oddity. It is defined there, then redefined in
> the arm header files, even though those header files are never included
> anywhere. Also, PIPE_BUF is never referenced by name in any of the Linux
> code. And yet, it is still being mentioned in some Big And Scary
> Warnings (tm): fs/autofs4/waitq.c or include/linux/pipe_fs_i.h, for
> example.

it's for userland to tell it what the size of the atomic pipe operations
we can do is.


