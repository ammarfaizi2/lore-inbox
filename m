Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbTEIIqj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 04:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbTEIIqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 04:46:39 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:56071 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262383AbTEIIqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 04:46:37 -0400
Message-ID: <3EBB6E98.4090305@aitel.hist.no>
Date: Fri, 09 May 2003 11:02:16 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.69-mm3 uncompilable config oddities
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: 2.5.69-mm3 don't compile if:
* crypto HMAC support is off
* PCI IDE chipset is selected but Generic PCI bus-master DMA is off

I tried to compile a kernel for a rescue disk - which
is supposed to be small.  So I disabled lots of stuff.
But crypto and HMAC is necessary, or I get missing symbols.
Other crypto algorithms can be turned off.

Why IDE without DMA?  Because that particular machine
happens to have the broken VIA chipset that IDE maintainers
don't want to hear any complaints about.  Why compile
in DMA support that can't be used anyway?  But my PIO only kernel
had missing symbols.  This is easily worked around by selecting
DMA and leaving "PCI DMA by default" off.

Helge Hafting

