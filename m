Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318218AbSIFBJl>; Thu, 5 Sep 2002 21:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318221AbSIFBJl>; Thu, 5 Sep 2002 21:09:41 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:35080 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318218AbSIFBJk>; Thu, 5 Sep 2002 21:09:40 -0400
Message-ID: <3D7800E9.94841744@zip.com.au>
Date: Thu, 05 Sep 2002 18:12:09 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Axel Siebenwirth <axel@hh59.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [OOPS:2.5.33-mm3] Oops with syslogd in generic_file_write_nolock
References: <20020906010428.GA252@prester.freenet.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Siebenwirth wrote:
> 
> Hi Andrew,
> 
> I just booted 2.5.33-mm3 and apparently when syslogd was started the
> following oops occurred.

Yup.  The readv/writev "improvements" are hilariously broken.  Suggest
you do a `patch -R' of 
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.33/2.5.33-mm3/broken-out/filemap-integration.patch
and generally think ill of me.
