Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262815AbVAFNnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbVAFNnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 08:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbVAFNnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 08:43:04 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:61363 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262815AbVAFNnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 08:43:01 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [PATCH] support for gzipped (ELF) core dumps
Date: Thu, 6 Jan 2005 13:43:00 +0000 (UTC)
Organization: Cistron Group
Message-ID: <crjf94$a03$1@news.cistron.nl>
References: <1105017578.28175.1.camel@borcx178>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1105018980 10243 62.216.29.200 (6 Jan 2005 13:43:00 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1105017578.28175.1.camel@borcx178>,
Jan Frey  <jan.frey@nokia.com> wrote:
>I've written a patch for 2.4.28 kernel which enables writing of core
>dump files for ELF binaries in .gz format. This is interesting when
>using and debugging large binaries. In my case core files exceeded 1GB
>and got written via NFS...
>Anyhow, below patch is not really "beautiful", especially CRC looks
>quite annoying here.

>+/* This table is needed for efficient CRC32 calculation */
>+static const unsigned long crc_table[8][256] = {
>+	{
>+		0x00000000UL, 0x77073096UL, 0xee0e612cUL, 0x990951baUL, 0x076dc419UL,

You know, this looks exactly the same as lib/crc32table.h ...
I'd consider using lib/crc32.c.

Mike.

