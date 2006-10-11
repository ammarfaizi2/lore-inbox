Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161527AbWJKVmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161527AbWJKVmH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161530AbWJKVmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:42:07 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:5855 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1161527AbWJKVlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:41:55 -0400
Date: Wed, 11 Oct 2006 14:41:11 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Chandra Seetharaman <sekharan@us.ibm.com>, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061011214111.GY7911@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Chandra Seetharaman <sekharan@us.ibm.com>,
	ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain> <20061010203511.GF7911@ca-server1.us.oracle.com> <20061011131935.448a8696.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011131935.448a8696.akpm@osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 01:19:35PM -0700, Andrew Morton wrote:
> The patch deletes a pile of custom code from configfs and replaces it with
> calls to standard kernel infrastructure and fixes a shortcoming/bug in the
> process.  Migration over to the new interface is trivial and almost
> scriptable.
> 
> Nice patch.  What's not to like about it??

	We're discussing it both online and offline because there are
concerns they have that do need to be addressed.
	What's not to like?  If you need more than 4K to display an
attribute, odds are you have more than one attribute in the file, which
is Wrong.  These guys, it turns out, don't, which is why I'm trying to
help them.  But I don't want to encourage others to do the wrong thing.
	I'm also unhappy with the lack of symmetry this creates on the
store/show() prototypes.  We're discussing whether the store() side
should support larger-than-a-page writes, and how to do it.

Joel

-- 

"Conservative, n.  A statesman who is enamoured of existing evils,
 as distinguished from the Liberal, who wishes to replace them
 with others."
	- Ambrose Bierce, The Devil's Dictionary

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
