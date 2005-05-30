Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVE3I00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVE3I00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 04:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVE3I00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 04:26:26 -0400
Received: from general.keba.co.at ([193.154.24.243]:7584 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261562AbVE3I0T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 04:26:19 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: RT patch acceptance
Date: Mon, 30 May 2005 10:25:47 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F367323223@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RT patch acceptance
Thread-Index: AcVkQ0ZaxJPwd6m4TGmygPb6wIkJnwAqttLA
From: "kus Kusche Klaus" <kus@keba.com>
To: "James Bruce" <bruce@andrew.cmu.edu>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: "Bill Huey \(hui\)" <bhuey@lnxw.com>, "Andi Kleen" <ak@muc.de>,
       "Sven-Thorsten Dietrich" <sdietrich@mvista.com>,
       "Ingo Molnar" <mingo@elte.hu>, <dwalker@mvista.com>,
       <hch@infradead.org>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nick Piggin wrote:
> > But nobody has been able to say why a single kernel is better than a
> > nanokernel.
> 
> I think it's a bit more like you haven't realized the answer 
> when people 
> gave it, so let me try to be more clear.  It's purely a 
> matter of effort 
> - in general it's far easier to write one process than two 
> communicating 
> processes.  As far as APIs, with a single-kernel approach, an RT 
> programmer just has to restrict the program to calling APIs 
> known to be 
> RT-safe (compare with MT-safe programming).  In a 
> split-kernel approach, 
> the programmer has to write RT-kernel support for the APIs he 
> wants to 
> use (or beg for them to be written).  Most programmers would 
> much rather 
> limit API usage than implement new kernel support themselves.

I strongly support this. It makes a big difference, not only from 
the technical point of view (as described above: developers have 
to master "two worlds"), but more importantly from the way
management sees things: As soon as some nanokernel or RT plus non-RT 
OS approach is mentioned, mgmt fears that there are two different 
sources of support (with the usual finger-pointing problems: "Not
our problem, report it to ..."), twice the patches and version 
hassles, additional legal issues and runtime license costs/troubles, 
two different development environments which must be supported 
by the central IT department, ...

When I was told to analyze whether linux is suitable for our
needs, any nanokernel or two-OS approaches were excluded from the
beginning: Mgmt thought that due to their nature and complexity,
such approaches are not able to offer any improvements w.r.t. what 
we have now. Clearly, "one system and one source" is wanted!

(we currently use a monolitic, "one-world" OS, but a commercial one)

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
