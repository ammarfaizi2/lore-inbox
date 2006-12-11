Return-Path: <linux-kernel-owner+w=401wt.eu-S935845AbWLKOdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935845AbWLKOdt (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 09:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935791AbWLKOdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 09:33:49 -0500
Received: from twin.jikos.cz ([213.151.79.26]:54065 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935845AbWLKOds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 09:33:48 -0500
Date: Mon, 11 Dec 2006 15:33:36 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-mm1
In-Reply-To: <457D6B10.4010903@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0612111532370.1665@twin.jikos.cz>
References: <20061211005807.f220b81c.akpm@osdl.org>
 <Pine.LNX.4.64.0612111137360.1665@twin.jikos.cz> <457D6B10.4010903@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006, Nick Piggin wrote:

> > Am I the only one seeing something strange on ext3 with this kernel? 
> > For example /etc/resolv.conf gets corrupted during the dhclient run. 
> > It looks like this, after dhclient finishes:
> Do you have CONFIG_DEBUG_VM turned on? I think we miss clearning BH_New
> in some places, thus causing an error path to zero the block incorrectly
> if we hit an error that CONFIG_DEBUG_VM makes much more likely.

Yes, I have. Will retry without it and let you know if the problem goes 
away.

Seems quite dangerous, a few minutes with 2.6.19-mm1 corrupted quite a lot 
of files on my fs.

-- 
Jiri Kosina
