Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751902AbWG1Dk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbWG1Dk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 23:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbWG1Dk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 23:40:56 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:6531 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751902AbWG1Dkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 23:40:53 -0400
Date: Fri, 28 Jul 2006 06:40:52 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
cc: Petr Baudis <pasky@suse.cz>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       alan@lxorguk.ukuu.org.uk, tytso@mit.edu, tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
In-Reply-To: <200607271930.k6RJUQ6s016546@laptop13.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.58.0607280636180.11711@sbz-30.cs.Helsinki.FI>
References: <200607271930.k6RJUQ6s016546@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006, Horst H. von Brand wrote:
> Doesn't that violate a POSIX guarantee that the lowest unused fd is
> returned? If the leakage lasts "long enough", this gives an opportunity of
> a nice DoS by using up fds...

The fd is not unused, its revoked. To clarify, the potential DoS is 
inherit for revoke, but since only root or the file owner can revoke a 
file, I don't see that as a big problem in practice. The caller is 
expected to ensure that no one can reopen the file anyway.

				Pekka
