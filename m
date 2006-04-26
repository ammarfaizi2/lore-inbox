Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWDZAq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWDZAq4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 20:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWDZAq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 20:46:56 -0400
Received: from uproxy.gmail.com ([66.249.92.171]:47648 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932323AbWDZAq4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 20:46:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HeyaoXQcqeH+gcJMPBEF6Tfh3iVQNuGRGL/VoDUWgF3UovVuG0rSaHYDeEoxTGe4/hWGS3Pbu+Xq7Gc54wIiZXwHb15z6lDjg668R4VJa6qHSsdmMNYM5GFooUft8ZV2HOVyD13jKLJWxF7Z46K7SHajFZjhFJhCFprlZfW3X98=
Message-ID: <9d955c940604251746j665eab5dmf4103673a749880f@mail.gmail.com>
Date: Wed, 26 Apr 2006 09:46:54 +0900
From: "Taeyoung Hong" <catchrye@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: process affinity problem
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when "root user" runs 4 HPL(High performance Linpack benchmark program
which is memory intesive, highly dependent on network latency) 
processes per node,
"top" shows good cpu affinity and good cpu performance.

but when a general user w/o root privilige runs the same benchmark program,
"top" shows cpu affinity sometimes broken, furthermore sometimes 2 hpl
programs runs the same cpu, after all which gives "poor benchmark
result"

I do not use special kernel parameter on boot, and the followings are
testbed's spec:
system: 4 cpus (2 sockets/ 2 core) opteron 275 blade server
memory nodes: 512MB *2 for a node  and 2GB*2 for the other node
OS: RHEL4 update2 w/ kernel 2.6.9-22.ELsmp
network driver: topspin IB implementation

Could you anyone explain about this awkward result?
