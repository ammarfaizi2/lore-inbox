Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVKRT7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVKRT7W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVKRT7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:59:22 -0500
Received: from web34109.mail.mud.yahoo.com ([66.163.178.107]:14936 "HELO
	web34109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932383AbVKRT7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:59:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=B1vEKSx/wejKzWPAGGhgQdSkU7Z+M6NYFmCleq3eDtQB3XG3i+6LSGfPkjz8JPn94pZNlr7vNij0EcbDloKOWgKTX8MqLSfvC9HIaaVph7VNCjr92OAwHonebmy+ocFGNZXhcBRPuzfniCO8I9aVLNZtKEDbIA5GOMIFq2pS8hw=  ;
Message-ID: <20051118195921.20264.qmail@web34109.mail.mud.yahoo.com>
Date: Fri, 18 Nov 2005 11:59:20 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: mmap over nfs leads to excessive system load
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Charles Lever <cel@citi.umich.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1132182378.8811.93.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another data point:

Under 2.6.8-2 (debain sarge kernel), the test does not cause a spin.
Instead, the file extension via pwrite does not allow the new pages to be usable by
remap_file_pages.
However, munmap/mmap are happy to use pages intoduces by the pwrite...
and happily writes more than 4GB.

-Kenny



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
