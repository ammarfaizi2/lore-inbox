Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbTGBItm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 04:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264860AbTGBItm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 04:49:42 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:19721 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264851AbTGBItl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 04:49:41 -0400
Message-ID: <3F02A171.7070200@aitel.hist.no>
Date: Wed, 02 Jul 2003 11:10:09 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm3 `highmem_start_page' undeclared  with DEBUG_PAGEALLOC
 and no highmem
References: <20030701203830.19ba9328.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This didn't compile.

.
.
.
   CC      arch/i386/mm/fault.o
   CC      arch/i386/mm/ioremap.o
   CC      arch/i386/mm/extable.o
   CC      arch/i386/mm/pageattr.o
arch/i386/mm/pageattr.c: In function `kernel_map_pages':
arch/i386/mm/pageattr.c:200: `highmem_start_page' undeclared (first use 
in this function)
arch/i386/mm/pageattr.c:200: (Each undeclared identifier is reported 
only once
arch/i386/mm/pageattr.c:200: for each function it appears in.)
make[1]: *** [arch/i386/mm/pageattr.o] Error 1
make: *** [arch/i386/mm] Error 2


Configuring highmem support to 4G instead of turning
it off avoids this, but I have only 512M in
this machine.

Turning off highmem and page allocation debugging
also compiles.

Helge Hafting

