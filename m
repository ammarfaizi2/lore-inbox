Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284675AbRLEUVS>; Wed, 5 Dec 2001 15:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284652AbRLEUTu>; Wed, 5 Dec 2001 15:19:50 -0500
Received: from leeloo.zip.com.au ([203.12.97.48]:7177 "EHLO
	mangalore.zipworld.com.au") by vger.kernel.org with ESMTP
	id <S284645AbRLEUTa>; Wed, 5 Dec 2001 15:19:30 -0500
Message-ID: <3C0E813D.F5B1F84E@zip.com.au>
Date: Wed, 05 Dec 2001 12:19:09 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Derek Glidden <dglidden@illusionary.com>
CC: linux-kernel@vger.kernel.org, bugs@linux-ide.org
Subject: Re: Random "File size limit exceeded" under 2.4
In-Reply-To: <1007573331.1809.6.camel@two>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derek Glidden wrote:
> 
> I've been experiencing random and occasional encounters with "File size
> limit exceeded" errors under 2.4 kernels when trying to make
> filesystems.

I don't know if anyone has come forth to fix this yet.

Apparently it's something to do with your shell setting
rlimits, and block devices are (bogusly) honouring those
settings.

The word is that if you log in as `root' at the login
prompt, rather than using `su', the problem goes away.
