Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVEQEeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVEQEeu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 00:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVEQEet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 00:34:49 -0400
Received: from ercist.iscas.ac.cn ([159.226.5.94]:8462 "EHLO
	ercist.iscas.ac.cn") by vger.kernel.org with ESMTP id S261247AbVEQEel
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 00:34:41 -0400
Subject: Re: [RFD] What error should FS return when I/O failure occurs?
From: fs <fs@ercist.iscas.ac.cn>
To: Chris Siebenmann <cks@utcc.utoronto.ca>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kenichi Okuyama <okuyama@intellilink.co.jp>
In-Reply-To: <05May16.114248edt.32448@gpu.utcc.utoronto.ca>
References: <05May16.114248edt.32448@gpu.utcc.utoronto.ca>
Content-Type: text/plain
Organization: iscas
Message-Id: <1116344580.2428.7.camel@CoolQ>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 17 May 2005 11:43:00 -0400
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 11:42, Chris Siebenmann wrote:
> You write:
> | When I/O failure occurs, there should be some standards which 
> | define the ONLY error that should be returned from VFS, right?
> 
>  In practice there is no standard and there never will be any standard.
> In general the only thing code can do on any write error is to abort
> the operation, regardless of what errno is. (The exceptions are for
> things like nonblocking IO, where 'EAGAIN' and 'EWOULDBLOCK' are not
> real errors.)
Yes, we're sure to abort the operation, but we can't use 
exit(EXIT_FAILURE) directly. For HA environment, we should
identify the cause of the error, take correspondent action,
right? So we need to get the right error.
> ---
> 	"I shall clasp my hands together and bow to the corners of the world."
> 			Number Ten Ox, "Bridge of Birds"
> cks@utcc.toronto.edu		   				    utgpu!cks

regards,
----
Qu Fuping


