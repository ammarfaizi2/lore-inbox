Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317887AbSHaTYV>; Sat, 31 Aug 2002 15:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSHaTYQ>; Sat, 31 Aug 2002 15:24:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8969 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317887AbSHaTYO>; Sat, 31 Aug 2002 15:24:14 -0400
Date: Sat, 31 Aug 2002 12:36:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Luca Barbieri <ldb@ldb.ods.org>
cc: trond.myklebust@fys.uio.no, Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
In-Reply-To: <1030820234.4408.119.camel@ldb>
Message-ID: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 31 Aug 2002, Luca Barbieri wrote:
>
> But aren't credential changes supposed to be infrequent?
> 
> If so, isn't it faster to put the fields directly in task_struct, keep a
> separate shared structure and copy them on kernel entry?

But that makes us copy them every time, even though they practically never 
change.. Much better to only copy them in the extremely rare cases when 
they do change.

		Linus

