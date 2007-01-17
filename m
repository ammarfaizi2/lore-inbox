Return-Path: <linux-kernel-owner+w=401wt.eu-S1751308AbXAQDwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbXAQDwi (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 22:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbXAQDwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 22:52:38 -0500
Received: from terminus.zytor.com ([192.83.249.54]:38249 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbXAQDwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 22:52:38 -0500
Message-ID: <45AD9D59.6010006@zytor.com>
Date: Tue, 16 Jan 2007 19:51:53 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: giuliano.procida@googlemail.com, rgooch@atnf.csiro.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: MTRR: fix 32-bit ioctls on x64_32
References: <200701161248.l0GCmG7O025771@harpo.it.uu.se>
In-Reply-To: <200701161248.l0GCmG7O025771@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> 
> These #ifdefs are too ugly.
> 
> Since you apparently just add aliases for the case labels,
> and do no actual code changes, why not
> 1. make the new cases unconditional, or 
> 2. invoke a translation function before the switch which
>    maps the MTRRCIOC32_ constants to what the kernel uses
> 

Adding a case can add substantially to the generated code, especially if 
it makes a compact set of case labels non-compact.

	-hpa
