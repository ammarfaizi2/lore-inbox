Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751567AbWGBRkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWGBRkp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 13:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWGBRkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 13:40:45 -0400
Received: from terminus.zytor.com ([192.83.249.54]:44229 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751546AbWGBRko
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 13:40:44 -0400
Message-ID: <44A80515.9010007@zytor.com>
Date: Sun, 02 Jul 2006 10:40:37 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       erik_frederiksen@pmc-sierra.com, linux-kernel@vger.kernel.org
Subject: Re: IS_ERR Threshold Value
References: <20060702161520.GA15791@linux-mips.org>
In-Reply-To: <20060702161520.GA15791@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> So MAX_ERRNO of EMAXERRNO which was also being used in assembler code.
> Other architectures may have the same issue, so I propose wrapping the
> C parts with #ifndef __ASSEMBLY__ to keep as happy.
> 

Indeed; this should definitely be accessible to assembly code.  I'd like 
to change the hard-coded constants in klibc over time to use this.

	-hpa
