Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWARP6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWARP6L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWARP6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:58:10 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:25553
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030363AbWARP6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:58:09 -0500
Message-Id: <43CE73A0.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 18 Jan 2006 16:58:08 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <tony.luck@intel.com>, "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Andrew Morton" <akpm@osdl.org>, "Paul Mackerras" <paulus@samba.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CONFIG_UNWIND_INFO
References: <4370AF4A.76F0.0078.0@novell.com>  <20060114045635.1462fb9e.akpm@osdl.org>  <17358.11049.367188.552649@cargo.ozlabs.ibm.com> <20060118151816.GA82365@muc.de>
In-Reply-To: <20060118151816.GA82365@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The module loader should be discarding these sections on most architectures
>because there is nothing that needs them and it's just a waste of memory
>to store them.
>
>[IA64 might be an exception because they have a kernel level unwinder]
>
>So it would be best to change the module loader to do this I guess.

But that's why this is a config option: You can prevent the data from being created in the first place if you know you
won't need it. For nlkd, adding code to discard these sections despite CONFIG_UNWIND_INFO would only make for more
differences, because I'd then have to undo this discarding.

Jan
