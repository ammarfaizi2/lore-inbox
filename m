Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268104AbUHFIw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268104AbUHFIw4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 04:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268050AbUHFIwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 04:52:55 -0400
Received: from holomorphy.com ([207.189.100.168]:22474 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268118AbUHFIvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 04:51:49 -0400
Date: Fri, 6 Aug 2004 01:51:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Andy Isaacson <adi@hexapodia.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "Mr. Berkley Shands" <berkley@cse.wustl.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Severe I/O performance regression 2.6.6 to 2.6.7 or 2.6.8-rc3
Message-ID: <20040806085137.GY17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Helge Hafting <helge.hafting@hist.no>,
	Andy Isaacson <adi@hexapodia.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	"Mr. Berkley Shands" <berkley@cse.wustl.edu>,
	linux-kernel@vger.kernel.org
References: <41126811.7020607@dssimail.com> <20040805172531.GC17188@holomorphy.com> <4112917A.3080003@cse.wustl.edu> <20040805204615.GJ17188@holomorphy.com> <20040805223319.GA18155@logos.cnet> <20040806020930.GA23072@hexapodia.org> <20040806022734.GN17188@holomorphy.com> <41134272.3080902@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41134272.3080902@hist.no>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Once we get there, there must be some way to construct intermediate
>> points between those two faithful at the very least to the snapshot
>> ordering if not true chronological ordering.

On Fri, Aug 06, 2004 at 10:33:54AM +0200, Helge Hafting wrote:
> You don't really need chronology for a binary search.  With a
> list of changesets, just apply/back out half of them.  Divide the lot
> any way you like, perhaps starting with only the "suspected" ones.

Wrong. Without chronology, one first of all gets an uncompileable tree
half the time, and second, more importantly, one has no method of
correlating the reconstructed source with user observations. Those
often come in the form of "version $FOO worked for me, but then I
upgraded to version $BAR, and the world exploded."

Between user-observable release points, one could say anything goes
modulo the first point, which is that this artifically-constructed
state may be complete gibberish from the standpoint of patches mixing.
But there is no way around the fact that user-observable release points
must be reconstructible and the ordering must be faithful to them. In
fact, this is so fine-grained as to include nightly snapshots.

-- wli
