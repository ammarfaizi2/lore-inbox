Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbWEKJET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbWEKJET (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 05:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbWEKJET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 05:04:19 -0400
Received: from mx1.suse.de ([195.135.220.2]:23528 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965211AbWEKJES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 05:04:18 -0400
Message-ID: <4462FE87.20009@suse.de>
Date: Thu, 11 May 2006 11:06:15 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060411)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: Zachary Amsden <zach@vmware.com>, virtualization@lists.osdl.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [Xen-devel] Re: [RFC PATCH 07/35] Make LOAD_OFFSET defined by
 subarch
References: <20060509084945.373541000@sous-sol.org> <20060509085150.509458000@sous-sol.org> <44627733.4010305@vmware.com> <4462EC05.8060705@suse.de> <20060511085127.GH25010@moss.sous-sol.org>
In-Reply-To: <20060511085127.GH25010@moss.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Gerd Hoffmann (kraxel@suse.de) wrote:
>> I fully agree.  Attached below is a patch (against xen unstable
>> mercurial tree) which does exactly that ;)
> 
> Thanks Gerd, I thought you had been working on that.  Was the concern
> with vaddr vs. paddr worked out?

Not yet, and I didn't feel comfortable pushing it just before the 3.0.2
release, but I think _now_ would be a good time to finally merge it.
Having physical addresses in paddr seems to be common practice, and IMO
xen should follow that as it makes life easier for everybody.

It's not a big problem that xen guests boot with paging enabled, and as
Zachary already pointed out it's trivial to use virt_base from the
xen_guest elf section to create correct initial page tables.

Even maintaining backward compatibility with some guesswork is possible
as it is _very_ unlikely that the paddr field holds physical addresses
larger than virt_base ;)

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
Erst mal heiraten, ein, zwei Kinder, und wenn alles läuft
geh' ich nach drei Jahren mit der Familie an die Börse.
http://www.suse.de/~kraxel/julika-dora.jpeg
