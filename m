Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbTDKMBx (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 08:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264336AbTDKMBx (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 08:01:53 -0400
Received: from holomorphy.com ([66.224.33.161]:53938 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264326AbTDKMBw (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 08:01:52 -0400
Date: Fri, 11 Apr 2003 05:13:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] first try for swap prefetch
Message-ID: <20030411121308.GC30376@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Thomas Schlichter <schlicht@uni-mannheim.de>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <200304101948.12423.schlicht@uni-mannheim.de> <20030410161826.04332890.akpm@digeo.com> <200304111352.05774.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304111352.05774.schlicht@uni-mannheim.de>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 01:51:55PM +0200, Thomas Schlichter wrote:
> Sorry, but I think I can not. The list_del() needs the value returned by 
> radix_tree_lookup(), so I can not kick it... By the way, the only reason for 
> the radix tree is to make this list_del() not O(n) for searching the list... 
> Do you know how expensive the radix_tree_lookup() is? O(1) or O(log(n))?? For 
> my shame I do not really know that data structure... :-(

It's O(lg(keyspace)). This is regarded as constant by many.


-- wli
