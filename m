Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263888AbTH1KH0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbTH1KH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:07:26 -0400
Received: from mail.webmaster.com ([216.152.64.131]:42690 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S263908AbTH1JSD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 05:18:03 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Timo Sirainen" <tss@iki.fi>, <nagendra_tomar@adaptec.com>
Cc: "Jamie Lokier" <jamie@shareable.org>, <root@chaos.analogic.com>,
       "Martin Konold" <martin.konold@erfrakon.de>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Lockless file reading
Date: Thu, 28 Aug 2003 02:17:55 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEIHFLAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <1062060035.1456.222.camel@hurina>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That was my original plan, to just rely on such kernel behaviour. I just
> don't know if it's such a good idea to rely on that, especially if I
> want to keep my program portable. I'll probably fallback to that anyway
> if my checksumming ideas won't work.

	If you only have one writer, why not have the writer update an MD5 checksum
in the file along with the datawrite? If the reader sees an invalid
checksum, it repeats the read. This is simple, elegant, and foolproof. The
only possible flaw would be if you found two data sets with the same MD5
checksum. The instant fame would be well worth the inconvenience. ;)

	DS


