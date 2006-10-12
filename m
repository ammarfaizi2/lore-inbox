Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWJLM4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWJLM4U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 08:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWJLM4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 08:56:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11662 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751373AbWJLM4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 08:56:19 -0400
Subject: Re: maybe headers(linux/aio.h) bug ?
From: David Woodhouse <dwmw2@infradead.org>
To: Dongsheng Song <dongsheng.song@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4b3406f0610120527g42bfbc44q45b31dc07f5968de@mail.gmail.com>
References: <4b3406f0610120527g42bfbc44q45b31dc07f5968de@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 13:56:16 +0100
Message-Id: <1160657777.9864.0.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 20:27 +0800, Dongsheng Song wrote:
> Whenever I include linux aio header,  the compile errors occured:
> 
> $  cat test.c
> #include <linux/types.h>
> #include <linux/unistd.h>
> #include <linux/aio.h> 

That's just broken. There should be no file /usr/include/linux/aio.h
because it isn't listed as one of the files to be exported from the
kernel when you run 'make headers_install'.

-- 
dwmw2

