Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTJOD6U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 23:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbTJOD6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 23:58:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:12473 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261916AbTJOD6T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 23:58:19 -0400
Date: Tue, 14 Oct 2003 20:57:02 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, clock@twibright.com
Subject: Re: Vortex 3c900 passing driver parameters
Message-Id: <20031014205702.140b6476.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
| Karel Kulhavý <clock@twibright.com> wrote:
| >
| > Hello
| > 
| > How do I do a ether=... (kernel boot-time) equivalent of
| > insmod 3c59x.o options=0x201 full_duplex=1 ?
| 
| Unfortunately you cannot.  `ether=' is broken for all drivers which use the
| new(ish) alloc_etherdev() API.
| 
| It is due to ordering problems: the name of the interface is not known at
| the time of parsing the setup info and nobody has got down and worked out
| how to fix it.

Does this ordering problem apply to both 2.4.current and 2.6.0-test?

--
~Randy
