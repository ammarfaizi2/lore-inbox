Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVFJWl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVFJWl6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 18:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVFJWkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 18:40:52 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:15628 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261308AbVFJWii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 18:38:38 -0400
Date: Sat, 11 Jun 2005 00:38:32 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: Alastair Poole <alastair@unixtrix.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: Unusual TCP Connect() results.
Message-ID: <20050610223832.GA31844@alpha.home.local>
References: <42A8ABDB.6080804@unixtrix.com> <42A9B193.1020602@stud.feec.vutbr.cz> <42A9C607.4030209@unixtrix.com> <42A9BA87.4010600@stud.feec.vutbr.cz> <20050610222645.GA1317@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610222645.GA1317@pcw.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 12:26:45AM +0200, Willy TARREAU wrote:
 
> $ sudo hping2 -c 1 -k -a 10.0.0.1 -s 80 -I lo 10.0.0.1 -p 80 -S -M 12345678

Sorry, it was -s 10000 and -p 10000, I copy-pasted the wrong history line.

I also have verified that 2.4.30 behaves the same way with the netcat test.
So the difference between old and new versions should be that new versions
are able to allocate a source port for connect() eventhough this one should
be marked as used because of the bind(). This does not seem critical at all
anyway.

Regards,
Willy

