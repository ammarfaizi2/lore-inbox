Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263599AbUD2GdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263599AbUD2GdF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 02:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263604AbUD2GdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 02:33:05 -0400
Received: from holomorphy.com ([207.189.100.168]:64385 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263599AbUD2GdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 02:33:02 -0400
Date: Wed, 28 Apr 2004 23:31:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       brettspamacct@fastclick.com, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429063153.GG737@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
	brettspamacct@fastclick.com, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40905127.3000001@fastclick.com> <20040428180038.73a38683.akpm@osdl.org> <16528.23219.17557.608276@cargo.ozlabs.ibm.com> <20040428185342.0f61ed48.akpm@osdl.org> <20040428194039.4b1f5d40.akpm@osdl.org> <16528.28485.996662.598051@cargo.ozlabs.ibm.com> <1083219158.20089.128.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083219158.20089.128.camel@gaston>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> The really strange thing is that the behaviour seems to get worse the
>> more RAM you have.  I haven't noticed any problem at all on my laptop
>> with 768MB, only on the G5, which has 2.5GB.  (The laptop is still on
>> 2.6.2-rc3 though, so I will try a newer kernel on it.)

On Thu, Apr 29, 2004 at 04:12:38PM +1000, Benjamin Herrenschmidt wrote:
> Your G5 also has a 2Gb IO hole in the middle of zone DMA, it's possible
> that the accounting doesn't work properly.

Hmm, ->present_pages vs. ->spanned_pages distinction(s) should cover
this, or should have at one point. How are those being set at the moment?


-- wli
