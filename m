Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263243AbUCTHki (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 02:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbUCTHki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 02:40:38 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:274 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263243AbUCTHkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 02:40:37 -0500
Date: Sat, 20 Mar 2004 07:40:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu hotplug fix
Message-ID: <20040320074033.A21586@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Anton Blanchard <anton@samba.org>, akpm@osdl.org,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <20040320063642.GF1153@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040320063642.GF1153@krispykreme>; from anton@samba.org on Sat, Mar 20, 2004 at 05:36:42PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 05:36:42PM +1100, Anton Blanchard wrote:
> 
> start_cpu_timer was changed to __init a few hours before the cpu hotplug
> patches went in. With cpu hotplug it can be called at any time, so fix
> this.

So we're wasting memory due to the few machines supporting hot-plug cpus
in slab now?  What about adding __cpuinit ala __devinit instead?

