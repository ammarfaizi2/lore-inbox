Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVCJMRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVCJMRN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 07:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVCJMRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 07:17:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10459 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262543AbVCJMRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 07:17:05 -0500
Date: Thu, 10 Mar 2005 12:17:01 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Omkhar Arasaratnam <iamroot@ca.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, tgall@us.ibm.com,
       antonb@au1.ibm.com, James Bottomley <James.Bottomley@SteelEye.com>,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [BUG] 2.6.11- sym53c8xx Broken on pp64
Message-ID: <20050310121701.GD21986@parcelfarce.linux.theplanet.co.uk>
References: <422FA817.4060400@ca.ibm.com> <1110420620.32525.145.camel@gaston> <422FBACF.90108@ca.ibm.com> <422FC042.40303@ca.ibm.com> <Pine.LNX.4.58.0503091944030.2530@ppc970.osdl.org> <1110434383.32525.184.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110434383.32525.184.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 04:59:43PM +1100, Benjamin Herrenschmidt wrote:
> Ok, we have it working here on a similar machine with 2.6.11 and failing
> in a similar way with bk which is why I asked ;)
> 
> The bk problem is found & fixed here tho. I'll send a patch later, it's
> a bug with ppc64 iounmap() not properly flushing the hash table after
> the set_pte_at() patch due to some crap in our custom implementation of
> that guy.

Heh, the devel version of sym2 (that isn't submitted yet because
it depends on a few changes to the SPI transport that James hasn't
integrated yet) would probably fix this as it doesn't call iounmap()
until the driver exits.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
