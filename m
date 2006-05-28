Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWE1XGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWE1XGZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 19:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWE1XGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 19:06:25 -0400
Received: from hera.kernel.org ([140.211.167.34]:30689 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751036AbWE1XGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 19:06:24 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: How to send a break?
Date: Sun, 28 May 2006 16:06:06 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e5dacu$v33$1@terminus.zytor.com>
References: <01b701c6818d$4bcd37b0$1800a8c0@dcccs>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1148857566 31844 127.0.0.1 (28 May 2006 23:06:06 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 28 May 2006 23:06:06 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <01b701c6818d$4bcd37b0$1800a8c0@dcccs>
By author:    =?iso-8859-2?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
In newsgroup: linux.dev.kernel
>
> Hello, list,
> 
> I wish to know, how to send a "BREAK" to trigger the sysreq functions on the
> serial line, using echo.
> 
> I mean like this:
> 
> #!/bin/bash
> echo "?BREAK?" >/dev/ttyS0
> sleep 2
> echo "m" >/dev/ttyS0
> 

You can't use it using echo, however, you can do it using Perl:

perl -e 'use POSIX; tcsendbreak(1,0);' > /dev/ttyS0

	-hpa
