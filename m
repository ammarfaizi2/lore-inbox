Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWJLTCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWJLTCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWJLTCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:02:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63410 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750796AbWJLTCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:02:48 -0400
Date: Thu, 12 Oct 2006 20:02:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
Subject: Re: [patch 0/2] Introduce round_jiffies() to save spurious wakeups
Message-ID: <20061012190244.GA31384@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <1160496165.3000.308.camel@laptopd505.fenrus.org> <20061011172331.GA13099@infradead.org> <1160589297.3000.389.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160589297.3000.389.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 07:54:57PM +0200, Arjan van de Ven wrote:
> > > An alternative would have been to introduce mod_timer_rounded() or
> > > somesuch APIs (but there's many variants that take jiffies); I feel that
> > > an explicit caller based rounding actually is quite reasonable.
> > 
> > I think the API you proposed is horrible.  Having jiffies exposed in
> > ani API is a mistake, and adding more makes this problem worse.  
> 
> and other people like Linus disagree with you.

The only argument from Linus was about getting rid of jiffies completly.
He certainly didn't complain when we added interfaces to reduce jiffies
use in the past (e.g. the msleep APIs)

