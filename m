Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268431AbUHLHMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268431AbUHLHMs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 03:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268433AbUHLHMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 03:12:48 -0400
Received: from proxy.kirov.ru ([217.9.147.44]:1293 "EHLO proxy.kirov.ru")
	by vger.kernel.org with ESMTP id S268431AbUHLHMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 03:12:39 -0400
Date: Thu, 12 Aug 2004 11:11:48 +0400
From: "Konstantin G. Khlebnikov" <c00nst@ezmail.ru>
X-Mailer: The Bat! (v1.62r)
Reply-To: "Konstantin G. Khlebnikov" <c00nst@ezmail.ru>
X-Priority: 3 (Normal)
Message-ID: <162420377.20040812111148@ezmail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re[2]: [QUESTION] shift pages in mmap
In-Reply-To: <Pine.LNX.4.44.0408111339040.23161-100000@dhcp83-102.boston.redhat.com>
References: <Pine.LNX.4.44.0408111339040.23161-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>    how implement fast page alligned shift (cyclic rotate)
>>    pages in anonymous mmap ?

RvR> Do you mean mremap(2) ?

not exactly, i found remap_file_pages(2) in 2.6

but i already wrote this (mmaped pipe) without any remaping
by only mmaping same file twice.

+------------+------------+
|  MAP       |  MAP       |
+------------+------------+
       ^DATADATA^
       |        |
        read ->  write ->

like queue with continuously block for read/write.

--
 Konstantin

