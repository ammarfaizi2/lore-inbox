Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313564AbSDHGSi>; Mon, 8 Apr 2002 02:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313566AbSDHGSh>; Mon, 8 Apr 2002 02:18:37 -0400
Received: from zok.sgi.com ([204.94.215.101]:20927 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S313564AbSDHGSg>;
	Mon, 8 Apr 2002 02:18:36 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Tom Holroyd <tomh@po.crl.go.jp>
Cc: marcelo@conectiva.com.br,
        kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Extraversion in System.map? 
In-Reply-To: Your message of "Mon, 08 Apr 2002 15:07:23 +0900."
             <Pine.LNX.4.44.0204081502180.548-100000@holly.crl.go.jp> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Apr 2002 16:18:15 +1000
Message-ID: <422.1018246695@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002 15:07:23 +0900 (JST), 
Tom Holroyd <tomh@po.crl.go.jp> wrote:
>As part of my penance for using the wrong System.map file in the
>readprofile data I sent out, I have prepared a patch to readprofile
>that makes it check the version of the file against the kernel.
>
>Much to my dismay, the extraversion code ('-pre6' for example) does
>not appear to be anywhere in System.map.  Or am I wrong?  If not, why
>not, and can this be fixed?  After all, symbols can and do change
>between -pre versions.

System.map only contains the numeric kernel version.  After all, it is
difficult to convert 2.4.19-pre6 to Version_132115-pre6 when symbols
cannot contain '-'.

Don't reinvent the wheel, use ksymoops -s save.map.  ksymoops has all
the verification code that I can think off, -s writes the merged map
including module information.

