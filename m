Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbWG0RF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWG0RF7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWG0RF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:05:59 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:6847 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751770AbWG0RF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:05:58 -0400
Date: Thu, 27 Jul 2006 20:05:57 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Ulrich Drepper <drepper@gmail.com>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, alan@lxorguk.ukuu.org.uk, tytso@mit.edu,
       tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
In-Reply-To: <a36005b50607270941n187e8b06ga9b1b6454cf2e548@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0607272004270.7152@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
 <a36005b50607270941n187e8b06ga9b1b6454cf2e548@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
> > +asmlinkage int sys_revoke(const char __user *filename)

On Thu, 27 Jul 2006, Ulrich Drepper wrote:
> Could we just plainly avoid adding any new syscalls which take a
> filename without extending the interface like the *at functions?
> I.e., add a file descriptor parameter, handle AT_FDCWD, etc.  The
> additional effort is really minimal.  Even if, as in this case, the
> function is propably not used in situations where the filename use is
> racy there are still those people to consider who want to implement a
> virtual per-thread current working directory.

Sure. Though I wonder if sys_frevoke is enough for us and we can drop 
sys_revoke completely.

				Pekka
