Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267424AbUJNT5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267424AbUJNT5X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbUJNTtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:49:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34962 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267421AbUJNTrs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:47:48 -0400
Date: Thu, 14 Oct 2004 20:47:47 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Dave Jones <davej@redhat.com>, Matthew Wilcox <matthew@wil.cx>,
       Brian Gerst <bgerst@didntduck.org>,
       "Martin K. Petersen" <mkp@wildopensource.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, akpm@osdl.org,
       tony.luck@intel.com
Subject: Re: [PATCH] General purpose zeroed page slab
Message-ID: <20041014194747.GV16153@parcelfarce.linux.theplanet.co.uk>
References: <yq1oej5s0po.fsf@wilson.mkp.net> <20041014173637.GQ16153@parcelfarce.linux.theplanet.co.uk> <20041014184915.GE18321@redhat.com> <200410142208.49831.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410142208.49831.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 10:08:49PM +0300, Denis Vlasenko wrote:
> BTW, zeroing with non-temporal stores may be a huge win here.
> It is 300% faster on Athlon.

That assumes the page isn't going to be reused quickly.  The point of
slab is that the page does get reused quickly.  So you *want* the data
to be hot in cache.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
