Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVCaOsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVCaOsc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 09:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVCaOsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 09:48:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63879 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261480AbVCaOrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 09:47:48 -0500
Date: Thu, 31 Mar 2005 15:47:40 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Christoph Hellwig <hch@infradead.org>,
       shobhit dayal <shobhit@calsoftinc.com>, christoph@lameter.com,
       manfred@colorfullife.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, linux-mm@kvack.org,
       Shai Fultheim <shai@scalex86.org>
Subject: Re: Fwd: [PATCH] Pageset Localization V2
Message-ID: <20050331144740.GB21986@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0503292147200.32571@server.graphe.net> <20050330111439.GA13110@infradead.org> <bab4333005033003295f487e3d@mail.gmail.com> <1112187977.9773.15.camel@kuber> <20050331143235.GA18058@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331143235.GA18058@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 03:32:35PM +0100, Christoph Hellwig wrote:
> Which would be much nicer done using INIT_LIST_HEAD on the new head
> always and then calling list_replace (of which currently only a _rcu variant
> exists).

INIT_LIST_HEAD followed by list_splice() should do the trick, I think.
BTW, is it a problem that the list head which the list was copied from
still points into the list?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
