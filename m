Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751887AbWG0Rqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbWG0Rqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbWG0Rqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:46:47 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7578 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750813AbWG0Rqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:46:46 -0400
Subject: Re: O_CAREFUL flag to disable open() side effects
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Ulrich Drepper <drepper@gmail.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       tytso@mit.edu, tigran@veritas.com
In-Reply-To: <44C8F8E3.1070306@zytor.com>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <a36005b50607270941n187e8b06ga9b1b6454cf2e548@mail.gmail.com>
	 <Pine.LNX.4.58.0607272004270.7152@sbz-30.cs.Helsinki.FI>
	 <1154021616.13509.68.camel@localhost.localdomain>
	 <44C8F8E3.1070306@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Jul 2006 19:05:16 +0100
Message-Id: <1154023516.13509.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-07-27 am 10:33 -0700, ysgrifennodd H. Peter Anvin:
> For a conventional file, directory, or block device O_CAREFUL is a 
> no-op.  For ttys it would typically behave similar to O_NONBLOCK 
> followed immediately by a fcntl to clear the nonblock flag.

Linus long ago suggested O_NONE to go with RO/RW/WO. Its not that hard
to do with the current file op stuff but you have to work out what the
access permission semantics of it are and what it means for ioctl etc

