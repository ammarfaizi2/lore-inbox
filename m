Return-Path: <linux-kernel-owner+w=401wt.eu-S1030471AbXAHD0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbXAHD0T (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 22:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbXAHD0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 22:26:19 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:62354 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030469AbXAHD0T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 22:26:19 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] Fix sparsemem on Cell (take 3)
Date: Sun, 7 Jan 2007 13:07:50 +0100
User-Agent: KMail/1.9.5
Cc: John Rose <johnrose@austin.ibm.com>, Andrew Morton <akpm@osdl.org>,
       External List <linuxppc-dev@ozlabs.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, kmannth@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>, hch@infradead.org,
       linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
       mkravetz@us.ibm.com, gone@us.ibm.com
References: <20061215165335.61D9F775@localhost.localdomain> <1168059162.23226.1.camel@sinatra.austin.ibm.com> <1168160307.6740.9.camel@localhost.localdomain>
In-Reply-To: <1168160307.6740.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701071307.52632.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 January 2007 09:58, Dave Hansen wrote:
> The following patch fixes an oops experienced on the Cell architecture
> when init-time functions, early_*(), are called at runtime.  It alters
> the call paths to make sure that the callers explicitly say whether the
> call is being made on behalf of a hotplug even, or happening at
> boot-time. 
> 
> It has been compile tested on ia64, s390, i386 and x86_64.

I can't test it here, since I'm travelling at the moment, but
this version looks good to me. Thanks for picking it up again!

> Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

Acked-by: Arnd Bergmann <arndb@de.ibm.com>
