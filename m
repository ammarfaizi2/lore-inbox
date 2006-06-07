Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWFGEIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWFGEIp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 00:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWFGEIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 00:08:45 -0400
Received: from hera.kernel.org ([140.211.167.34]:23961 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750783AbWFGEIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 00:08:44 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: AMD64: 64 bit kernel 32 bit userland - some pending questions
Date: Tue, 6 Jun 2006 21:08:26 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e65jfq$m6v$1@terminus.zytor.com>
References: <787b0d920606062011j21083e80v659228a7565ecfab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1149653306 22752 127.0.0.1 (7 Jun 2006 04:08:26 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 7 Jun 2006 04:08:26 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <787b0d920606062011j21083e80v659228a7565ecfab@mail.gmail.com>
By author:    "Albert Cahalan" <acahalan@gmail.com>
In newsgroup: linux.dev.kernel
> 
> The bigger problem is that 32-bit code has fewer CPU registers.
> (nobody has done an ILP32 ABI for long mode) This is slow.
> 

The issue isn't the ABI, the issue is that the processor doesn't
support it, since some of the opcodes mean different things in 16-,
32- and 64-bit mode.  The opcodes which access the high half of the
register sets (REX prefixes) in 64-bit mode are INC and DEC
instructions in 16- and 32-bit mode.

AMD was apparently considering adding a "REX32" mode at some point,
but rather predictably noone was interested enough to make it
worthwhile.

	-hpa

