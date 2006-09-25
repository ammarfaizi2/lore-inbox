Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWIYQzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWIYQzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 12:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWIYQzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 12:55:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:457 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751240AbWIYQzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 12:55:03 -0400
Date: Mon, 25 Sep 2006 17:54:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Paul E McKenney <paulmck@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [-mm PATCH 1/4] RCU: split classic rcu
Message-ID: <20060925165433.GA28898@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Paul E McKenney <paulmck@us.ibm.com>,
	Ingo Molnar <mingo@elte.hu>
References: <20060923152957.GA13432@in.ibm.com> <20060923153141.GB13432@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923153141.GB13432@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 09:01:41PM +0530, Dipankar Sarma wrote:
> 
> This patch re-organizes the RCU code to enable multiple implementations
> of RCU. Users of RCU continues to include rcupdate.h and the
> RCU interfaces remain the same. This is in preparation for
> subsequently merging the preepmtpible RCU implementation.

I still disagree very strongly.  In a given tree there should be oneRCU
implementation for the traditional interface.  We probably want srcu
in addition, but not things hiding behind the interface.
