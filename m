Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbSLTMqh>; Fri, 20 Dec 2002 07:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbSLTMqg>; Fri, 20 Dec 2002 07:46:36 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:61346 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262190AbSLTMqf>;
	Fri, 20 Dec 2002 07:46:35 -0500
Date: Fri, 20 Dec 2002 12:54:00 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: xela@slit.de
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zero-size E820 memory (kernel start-up failure)
Message-ID: <20021220125400.GB28068@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, xela@slit.de,
	hpa@zytor.com, linux-kernel@vger.kernel.org
References: <3E02F8E1.70509@slit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E02F8E1.70509@slit.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 12:02:57PM +0100, Alexander Achenbach wrote:

 > Up to 2.4.20, a zero-size E820 memory region (eg 0xa0000 - 0xa0000)
 > reported by the BIOS causes 'sanitize_e820_map' to take the end of this
 > region as the start of another region, producing two overlapping regions
 > extending to the end of addressable memory. If the zero-size region is of
 > a higher type than 'usable RAM' (eg 'reserved'), this causes all memory
 > above the zero-size region to be marked unusable (leaving 640k as of the
 > above example -- the kernel fails to start at all).
 > 
 > The patch adds code to remove empty entries before sorting regions. It
 > was generated for a 2.4.20 kernel.

Looks good to me. Care to do a similar patch for 2.5 ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
