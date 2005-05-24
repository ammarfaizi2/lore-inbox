Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVEXFr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVEXFr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 01:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVEXFr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 01:47:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53900 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261271AbVEXFrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 01:47:23 -0400
Date: Tue, 24 May 2005 06:47:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       sdietrich@mvista.com
Subject: Re: RT patch acceptance
Message-ID: <20050524054722.GA6160@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
	mingo@elte.hu, akpm@osdl.org, sdietrich@mvista.com
References: <1116890066.13086.61.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116890066.13086.61.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2005 at 04:14:26PM -0700, Daniel Walker wrote:
> Hello World!
> 
> I went to see Andrew Morton speak at Xerox PARC and he indicated that
> some of the RT patch was a little crazy . Specifically interrupts in
> threads (Correct me if I'm wrong Andrew). It seems a lot of the
> maintainers haven't really warmed up to it. 
> 
> I don't know to what extent Ingo has lobbied to try to get acceptance
> into an unstable or stable kernel. However, since I know Andrew is cold
> to accepting it , I thought I would ask what would need to be done to
> the RT patch so that it could be accepted?
> 
> I think the fact that some distributions are including RT patched
> kernels is a sign that this technology is getting mature. Not to mention
> the fact that it's a 600k+ patch and getting bigger everyday. 
> 
> I'm sure there are some people fiercely opposed to it, some of whom I've
> already run into. What is it about RT that gets people's skin crawling?
> It is a configure option after all.

Personally I think interrupt threads, spinlocks as sleeping mutexes and PI
is something we should keep out of the kernel tree.  If you want such
advanced RT features use a special microkernel and run Linux as user
process, using RTAI or maybe soon some of the more sofisticated virtualization
technologies.

