Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278737AbRJVL5J>; Mon, 22 Oct 2001 07:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278742AbRJVL47>; Mon, 22 Oct 2001 07:56:59 -0400
Received: from mail.zmailer.org ([194.252.70.162]:50949 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S278747AbRJVL4v>;
	Mon, 22 Oct 2001 07:56:51 -0400
Date: Mon, 22 Oct 2001 14:57:11 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: =?iso-8859-1?Q?Roar_Thron=E6s?= <roart@nvg.ntnu.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: increase the number of system call parameters
Message-ID: <20011022145711.G24643@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.33.0110221334200.1121-100000@hagbart.nvg.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0110221334200.1121-100000@hagbart.nvg.ntnu.no>; from roart@nvg.ntnu.no on Mon, Oct 22, 2001 at 01:48:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2001 at 01:48:26PM +0200, Roar Thronæs wrote:
> Hi
> 
> How do you increase the number of system call parameters, and how many
> can you at most have?
> Would up to 12 parameters be possible, and how?

  Why ?  Would it not make sense to have 2-3 params, one of them
being a pointer to a structure passing complicated dataset ?
(And first of the structure elements being version number so you
 can version the syscall, e.g. add more things/differently structured
 things latter -- and remember to supply specific errno which is
 telling that particular version is not understood by the kernel.)

For example the kernel does not have   mmap64(),   but it has  mmap2()
which passes the large number of parameters in a structure, and the
libc has a wrapper function implementing  mmap64()  call API.

At register-rich systems that is not absolutely necessary, but at
register-starved things, like i386, you have no real other way.

> -- 
> -Roar Thronæs

/Matti Aarnio
