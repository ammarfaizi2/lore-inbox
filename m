Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbVCWSH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbVCWSH3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 13:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbVCWSH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 13:07:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58841 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262775AbVCWSHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 13:07:14 -0500
Date: Wed, 23 Mar 2005 10:05:43 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: aq <aquynh@gmail.com>
Cc: mlists@tanael.org, Hikaru1@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
Message-Id: <20050323100543.04e582e9.pj@engr.sgi.com>
In-Reply-To: <9cde8bff05032309056c9643a7@mail.gmail.com>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
	<20050322112628.GA18256@roll>
	<Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
	<20050322124812.GB18256@roll>
	<20050322125025.GA9038@roll>
	<9cde8bff050323025663637241@mail.gmail.com>
	<1111581459.27969.36.camel@nc>
	<9cde8bff05032305044f55acf3@mail.gmail.com>
	<1111586058.27969.72.camel@nc>
	<9cde8bff05032309056c9643a7@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> int main() { while(1) { fork(); fork(); exit(); } }
> ...
> the above forkbomb will stop quickly

Yep.

Try this forkbomb:

  int main() { while(1) { if (!fork()) continue; if (!fork()) continue; exit(); } }

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
