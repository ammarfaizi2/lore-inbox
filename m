Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVAaWOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVAaWOH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVAaWOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:14:06 -0500
Received: from opersys.com ([64.40.108.71]:65292 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261406AbVAaWNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:13:42 -0500
Message-ID: <41FEACD3.10502@opersys.com>
Date: Mon, 31 Jan 2005 17:10:27 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Tom Zanussi <zanussi@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>
Subject: Re: [PATCH] relayfs redux, part 2
References: <16890.38062.477373.644205@tut.ibm.com> <20050129081527.GD7738@kroah.com>
In-Reply-To: <20050129081527.GD7738@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH wrote:
> On Fri, Jan 28, 2005 at 01:38:22PM -0600, Tom Zanussi wrote:
> 
>>+extern void * alloc_rchan_buf(unsigned long size,
>>+			      struct page ***page_array,
>>+			      int *page_count);
>>+extern void free_rchan_buf(void *buf,
>>+			   struct page **page_array,
>>+			   int page_count);
> 
> 
> As these will be "polluting" the global namespace of the kernel, could
> you add "relayfs_" to the front of them?

BTW, these functions are in buffers.h which is an internal header to
fs/relayfs/*.c files. buffers.h is not included in anything outside.
Correct me if I'm wrong, but there is no namespace pollution in that
case, right? All that does contribute to namespace pollution is in
include/linux/relayfs_fs.h.

Thanks,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
