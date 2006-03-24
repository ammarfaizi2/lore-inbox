Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWCXPmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWCXPmf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWCXPmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:42:35 -0500
Received: from fmr18.intel.com ([134.134.136.17]:14743 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750976AbWCXPme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:42:34 -0500
Message-ID: <44241359.3070409@linux.intel.com>
Date: Fri, 24 Mar 2006 16:42:17 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Ashok Raj <ashok.raj@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Ignore MCFG if the mmconfig area isn't reserved in thee820
 table
References: <1143138170.3147.43.camel@laptopd505.fenrus.org> <20060324072250.A13756@unix-os.sc.intel.com> <44240F30.10801@linux.intel.com> <200603241639.54192.ak@suse.de>
In-Reply-To: <200603241639.54192.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> In theory they should be the same. What do you think is different?

in practice the x86-64 version returns "success" if there is one byte in the entire
memory range that complies with the requested type, even if the rest of the range is
of another type. What the ideal is for the purpose here is "is the entire range reserved",
but for now I'll settle for "is the start address reserved".

(and yes you can express the "is the start address reserved" as a question to the current function for
a 1 byte range, I probably should do that I suppose)
