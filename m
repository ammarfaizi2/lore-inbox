Return-Path: <linux-kernel-owner+w=401wt.eu-S1750859AbXAIChZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbXAIChZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 21:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbXAIChZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 21:37:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42421 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbXAIChY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 21:37:24 -0500
Subject: Re: agpgart: drm-populated memory types
From: Arjan van de Ven <arjan@infradead.org>
To: thomas@tungstengraphics.com
Cc: davej@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <11682488182899-git-send-email-thomas@tungstengraphics.com>
References: <1166533877.3365.1244.camel@laptopd505.fenrus.org>
	 <11682488182899-git-send-email-thomas@tungstengraphics.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 08 Jan 2007 18:37:11 -0800
Message-Id: <1168310231.3180.80.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> A short recap why I belive the kmalloc / vmalloc construct is necessary:
> 
> 0) The current code uses vmalloc only.
> 1) The allocated area ranges from 4 bytes possibly up to 512 kB, depending on
> on the size of the AGP buffer allocated.
> 2) Large buffers are very few. Small buffers tend to be quite many. 
>    If we continue to use vmalloc only or another page-based scheme we will
>    waste approx one page per buffer, together with the added slowness of
>    vmalloc. This will severely hurt applications with a lot of small
>    texture buffers.
> 
> Please let me know if you still consider this unacceptable.

explicit use of either kmalloc/vmalloc is fine with me; I would suggest
an 2*PAGE_SIZE cutoff for this decision

>  
> In that case I suggest sticking with vmalloc for now.
> 
> Also please let me know if there are other parths of the patch that should be
> reworked.
> 
> The patch that follows is against Dave's agpgart repo.
> 
<you forgot the patch>

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

