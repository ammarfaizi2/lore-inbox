Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316892AbSFFMvl>; Thu, 6 Jun 2002 08:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316906AbSFFMvk>; Thu, 6 Jun 2002 08:51:40 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:41228 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316892AbSFFMvk>;
	Thu, 6 Jun 2002 08:51:40 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre10-ac2 
In-Reply-To: Your message of "Thu, 06 Jun 2002 11:11:09 +0100."
             <Pine.LNX.4.44.0206061110410.16548-100000@jester.mews> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jun 2002 22:51:31 +1000
Message-ID: <4646.1023367891@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2002 11:11:09 +0100 (BST), 
Matt Bernstein <matt@theBachChoir.org.uk> wrote:
>Since when was it OK to do a parallel make dep?

Arch dependent.  Parallel make dep will generate incomplete output on
some architectures, mainly those that generate files at make dep time.
mkdep.c only adds .h files to .[h]depend if the file exists.  With
parallel make dep the scanning of .c files can occur before the .h
files have been generated, resulting in an incomplete dependency tree.
Later changes may not rebuild everything that should be rebuilt.

Not a problem for kbuild 2.5 of course.

