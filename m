Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265869AbUBPUU7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 15:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265876AbUBPUU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 15:20:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49811 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265869AbUBPUU5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 15:20:57 -0500
Message-ID: <4031261C.8070406@pobox.com>
Date: Mon, 16 Feb 2004 15:20:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Lehmann <pcg@schmorp.de>
CC: John Bradford <john@grabjohn.com>, Linus Torvalds <torvalds@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <4031197C.1040909@pobox.com> <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk> <20040216201610.GC17015@schmorp.de>
In-Reply-To: <20040216201610.GC17015@schmorp.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Lehmann wrote:
> The point here is that the kernel does, in a very narrow interpretation,
> not support the use of UTF-8, because proper support of UTF-8 means that
> no illegal byte sequences will be produced.

Incorrect.  Byte stream transports need not care about their contents.

The only places that need to care about illegal UTF8 byte sequences are 
things like CONFIG_NLS_UTF8.

	Jeff



