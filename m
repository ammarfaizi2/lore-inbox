Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbTJQWUm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 18:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTJQWUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 18:20:42 -0400
Received: from fmr05.intel.com ([134.134.136.6]:3456 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S263618AbTJQWUk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 18:20:40 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [RFC] prevent "dd if=/dev/mem" crash
Date: Fri, 17 Oct 2003 15:19:49 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0F367D@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] prevent "dd if=/dev/mem" crash
Thread-Index: AcOU+5ym6z4CSgXZQGGsauwESZj8PgAAJtjg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Oct 2003 22:19:52.0781 (UTC) FILETIME=[C961DFD0:01C394FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I expect there are probably different opinions about the idea
> that "dd if=/dev/mem" exits without doing anything.  Sparc and
> 68K have nearby code that bit-buckets writes and returns zeroes
> for reads of page zero.  We could do that, too, but it seems like
> kind of a hack, and holes on ia64 can be BIG (on the order of
> 256GB for one box).

Filling in the holes does seem like a bad idea, but so does returning
EOF when you hit a hole (which is what I think your patch is doing).

Would ENODEV be better?

-Tony
