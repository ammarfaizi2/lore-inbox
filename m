Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263557AbUEKTzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263557AbUEKTzV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 15:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUEKTzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 15:55:21 -0400
Received: from mailgate1b.savvis.net ([216.91.182.6]:39329 "EHLO
	mailgate1b.savvis.net") by vger.kernel.org with ESMTP
	id S263557AbUEKTzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 15:55:17 -0400
From: "Dan A. Dickey" <dan.dickey@savvis.net>
Reply-To: dan.dickey@savvis.net
Organization: WAM!NET a Division of SAVVIS, Inc.
To: "David S. Miller" <davem@redhat.com>
Subject: Re: Sock leak in net/ipv4/af_inet.c - 2.4.26
Date: Tue, 11 May 2004 14:55:11 -0500
User-Agent: KMail/1.6.2
Cc: <m.c.p@kernel.linux-systeme.com>, <linux-kernel@vger.kernel.org>,
       <kuznet@ms2.inr.ac.ru>
References: <20040511115934.0c591667.davem@redhat.com>
In-Reply-To: <20040511115934.0c591667.davem@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405111455.11935.dan.dickey@savvis.net>
X-ECS-MailScanner: No virus is found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 May 2004 13:59, David S. Miller wrote:
> The sk_free() should occur when the final sock_put() call brings the count
> down to zero, then the socket destroy function is called and the eventual
> sk_free() occurs there.

Yes, I'm figuring this out.
I think my earlier report of this problem was a bit premature.
I'm refining my debug code and will let you know what I find.
	-Dan

-- 
Dan A. Dickey
dan.dickey@savvis.net
