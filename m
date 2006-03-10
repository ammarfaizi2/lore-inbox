Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751963AbWCJBpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbWCJBpH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbWCJBpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:45:07 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:59862 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751963AbWCJBpF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:45:05 -0500
Date: Fri, 10 Mar 2006 01:44:57 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>,
       "David S. Miller" <davem@davemloft.net>, davej@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: filldir[64] oddness
Message-ID: <20060310014457.GV27946@ftp.linux.org.uk>
References: <20060309042744.GA23148@redhat.com> <20060308.203204.115109492.davem@davemloft.net> <20060309044025.GS27946@ftp.linux.org.uk> <1141923743.17294.8.camel@localhost.localdomain> <0A5868C4-CC2D-443D-8340-9F0AB2E0A94C@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0A5868C4-CC2D-443D-8340-9F0AB2E0A94C@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 08:41:08PM -0500, Kyle Moffett wrote:
> Yeah, IMHO it's not really worth optimizing for the obscure and oddly- 
> defined cases unless you can actually find valid places where that  
> code comes up understandably.  In this particular case, the Coverity  
> checker is indirectly pointing out that the code is confusing to the  
> reader and could inadvertently be massively broken by changing the  
> type of d_name.

Bullshit.  It is very directly pointing out that it has broken handling
of C types (obscure case, my arse - decay of arrays to pointers), has no
regression testsuite and most likely doesn't even get applied to its own
source on a regular basis.
