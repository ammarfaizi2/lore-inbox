Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVJ0RCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVJ0RCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 13:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVJ0RCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 13:02:43 -0400
Received: from pat.uio.no ([129.240.130.16]:50646 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751149AbVJ0RCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 13:02:43 -0400
Subject: Re: is rpc_call blocking and wait for reponse before returning to
	the caller?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4ae3c140510270945w286cbcf5j7e7a4bde454526b5@mail.gmail.com>
References: <4ae3c140510270945w286cbcf5j7e7a4bde454526b5@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 13:02:24 -0400
Message-Id: <1130432544.21372.35.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.822, required 12,
	autolearn=disabled, AWL 1.99, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 27.10.2005 klokka 12:45 (-0400) skreiv Xin Zhao:
> I am trying to implement a mechanism similar to rpc. So I might want
> to know whether rpc_call return only after it receive response from
> the server.

In newer kernels rpc_call is just a wrapper to rpc_call_sync() which is
the synchronous RPC call interface. That will always wait for a response
from the server before returning if the clnt->cl_soft flag is not set.

For asynchronous operation, there is rpc_call_async().

Cheers,
  Trond

