Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265084AbTFYV70 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 17:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265091AbTFYV70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 17:59:26 -0400
Received: from air-2.osdl.org ([65.172.181.6]:38829 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265084AbTFYV7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 17:59:25 -0400
Date: Wed, 25 Jun 2003 15:13:26 -0700
From: Bob Miller <rem@osdl.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: "J.C. Wren" <jcwren@jcwren.com>, linux-kernel@vger.kernel.org
Subject: Re: Assorted warnings while building 2.5.73
Message-ID: <20030625221326.GA1409@doc.pdx.osdl.net>
References: <57481010E50@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57481010E50@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 11:25:35PM +0200, Petr Vandrovec wrote:
> On 25 Jun 03 at 16:25, J.C. Wren wrote:
> > drivers/video/matrox/matroxfb_g450.c: In function `g450_compute_bwlevel':
> > drivers/video/matrox/matroxfb_g450.c:129: warning: duplicate `const'
> > drivers/video/matrox/matroxfb_g450.c:130: warning: duplicate `const'
> 
> Fix min/max macros and/or learn gcc that "const typeof(x)" where x
> is already const type is OK. Or I can code it with simple if(), but
> why we have min/max macros then?
> 
> Is there some __attribute__((-Wno-duplicate-const)) ?
>                                          Petr Vandrovec
>                                          vandrove@vc.cvut.cz
>                                          
> 
Or use a newer compiler that has this fixed, or use min_t()/max_t()
instead.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
