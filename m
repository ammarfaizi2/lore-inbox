Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285384AbRLGCvQ>; Thu, 6 Dec 2001 21:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285385AbRLGCvG>; Thu, 6 Dec 2001 21:51:06 -0500
Received: from pizda.ninka.net ([216.101.162.242]:36225 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285384AbRLGCut>;
	Thu, 6 Dec 2001 21:50:49 -0500
Date: Thu, 06 Dec 2001 18:50:19 -0800 (PST)
Message-Id: <20011206.185019.30186165.davem@redhat.com>
To: lm@bitmover.com
Cc: alan@lxorguk.ukuu.org.uk, phillips@bonn-fries.net, davidel@xmailserver.org,
        rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011206183451.A4235@work.bitmover.com>
In-Reply-To: <20011206143516.P27589@work.bitmover.com>
	<E16C7P1-0003Ou-00@the-village.bc.nu>
	<20011206183451.A4235@work.bitmover.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Larry McVoy <lm@bitmover.com>
   Date: Thu, 6 Dec 2001 18:34:51 -0800

   The data is all in a shared file system, nice and coherent, the
   apps don't actually know there is another OS banging on the data,
   it all just works.

Larry1: "One way to get the ccCluster scalability is by un-globalizing
         the filesystem"

Larry2: "Let me tell you about this great application of ccClusters,
	 it involves using a shared file system.  It all just works."

Either you're going to replicate everyone's content or you're going to
use a shared filesystem.  In one case you'll go fast but have the same
locking problems as a traditional SMP, in the other case you'll go
slow because you'll be replicating all the time.

Which is it :-)

What I suppose is coming up is some example application that really
doesn't need a shared filesystem, which I bet will be a quite obscure
one or at least obscure enough that it can't justify ccCluster all on
it's own.
