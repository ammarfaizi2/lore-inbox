Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266609AbSLJGAT>; Tue, 10 Dec 2002 01:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266615AbSLJGAT>; Tue, 10 Dec 2002 01:00:19 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:15120 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S266609AbSLJGAS>; Tue, 10 Dec 2002 01:00:18 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: capable open_port() check wrong for kmem
Date: 10 Dec 2002 05:45:09 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <at3v15$mur$1@abraham.cs.berkeley.edu>
References: <20021210032242.GA17583@net-ronin.org>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1039499109 23515 128.32.153.211 (10 Dec 2002 05:45:09 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 10 Dec 2002 05:45:09 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

carbonated beverage  wrote:
>	I found that I can't open /dev/kmem O_RDONLY.  The open_mem
>and open_kmem calls (open_port()) in drivers/char/mem.c checks for
>CAP_SYS_RAWIO.
>
>	Is there a possibility of splitting that off into a read and
>write pair, i.e. CAP_SYS_RAWIO_WRITE, CAP_SYS_RAWIO_READ?

Read-only access to /dev/kmem is probably enough to get root access
(maybe you can snoop root's password, for instance).  This would make
the power of the two capabilities roughly equivalent, so if this is true,
I'm not sure I understand the point of splitting them in two this way.
