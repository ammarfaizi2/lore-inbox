Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVC2PiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVC2PiL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 10:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVC2PiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 10:38:11 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60609 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262318AbVC2PiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 10:38:09 -0500
Date: Tue, 29 Mar 2005 07:35:58 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       johnpol@2ka.mipt.ru, jlan@engr.sgi.com, efocht@hpce.nec.com,
       linuxram@us.ibm.com, gh@us.ibm.com, elsa-devel@lists.sourceforge.net
Subject: Re: [patch 1/2] fork_connector: add a fork connector
Message-Id: <20050329073558.797001c1.pj@engr.sgi.com>
In-Reply-To: <1112100675.8426.72.camel@frecb000711.frec.bull.fr>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	<20050328134242.4c6f7583.pj@engr.sgi.com>
	<1112100675.8426.72.camel@frecb000711.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume wrote:
> I ran some test using the CBUS instead of the cn_netlink_send() routine
> and the overhead is nearly 0%:

Overhead of what?  Does this include merging the data and getting it to
disk?

Am I even asking the right question here - is it true that this data,
when collected for accounting purposes, needs to go to disk, and that
summarizing and analyzing the data is done 'off-line', perhaps hours
later?  That's the way it was 25 years ago ... but perhaps the basic
data flow appropriate for accounting has changed since then.

And if the data flow has changed, then how to you account for the fact
that the rest of the accounting data, under the CONFIG_BSD_PROCESS_ACCT
option, is still collected the 'old fashioned way' (direct kernel write
to disk)?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
