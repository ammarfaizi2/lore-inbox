Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263883AbTLORYP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 12:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbTLORYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 12:24:15 -0500
Received: from fmr99.intel.com ([192.55.52.32]:55211 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263883AbTLORYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 12:24:12 -0500
Message-ID: <3FDDEE32.7050900@intel.com>
Date: Mon, 15 Dec 2003 19:24:02 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Mares <mj@ucw.cz>
Subject: Re: PCI Express support for 2.4 kernel
References: <Pine.LNX.4.44.0312150917170.32061-100000@coffee.psychology.mcmaster.ca> <3FDDD8C6.3080804@intel.com> <3FDDDC68.80209@backtobasicsmgmt.com> <3FDDE39E.1050300@intel.com> <Pine.LNX.4.53.0312151150090.10342@chaos>
In-Reply-To: <Pine.LNX.4.53.0312151150090.10342@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
<discussion regarding initializers for static vars>

Let's stop this discussion, it leads to nowhere. Probable, yes, 
initializer do add bytes to the data segment. But it does not make 
difference for memory image after loading, do it?

Does this difference in executable size worth potential risk of error?

Anyway, common style in kernel seems to be to do initialize static vars, 
even to 0. There are plenty of examples, including the same file, (for 
2.4.23)

arch/i386/kernel/pci-pc.c:32
static int pci_using_acpi_prt = 0;

or

arch/i386/kernel/setup.c:1241
static int tsc_disable __initdata = 0;

Finally, let's stop this thread. Let it be up to person who will be (if 
it will happen) checking this code into kernel, to decide on coding 
style. I, personally, value code clarity more then 4 bytes in executable 
size. But I will not object if more experienced kernel maintainers have 
another priority.

Vladimir.
