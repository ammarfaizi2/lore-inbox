Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbUKAMa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbUKAMa4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 07:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbUKAMaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 07:30:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:50097 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261172AbUKAMav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 07:30:51 -0500
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041031201500.GA4498@thunk.org>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
	 <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1099170891.1424.1.camel@krustophenia.net>
	 <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
	 <20041030222720.GA22753@hockin.org> <4184193A.3060406@pobox.com>
	 <20041031201500.GA4498@thunk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099308472.18809.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 01 Nov 2004 11:27:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-10-31 at 20:15, Theodore Ts'o wrote:
> .... if you don't mind bloating your application:
> 
> % ls -l /usr/lib/libxml2.a
> 4224 -rw-r--r--  1 root root 4312536 Oct 19 21:55 /usr/lib/libxml2.a

Except that
1. The file size has nothing to do with the binary size as it is full of
symbols and maybe debug
2. Most of the pages of libxml2.so don't get paged in by a typical
application
3. If you have existing apps using it then its cost to you is nearly
zero because its already loaded.

libxml2 is a very complete validating all singing all dancing XML
parser. There are small non-validating parsers without every conceivable
glue interface that come down to about 10K.


