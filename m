Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbVIEGXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVIEGXk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 02:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVIEGXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 02:23:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43160 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932250AbVIEGXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 02:23:38 -0400
Date: Mon, 5 Sep 2005 14:29:16 +0800
From: David Teigland <teigland@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050905062916.GA17607@redhat.com>
References: <20050901104620.GA22482@redhat.com> <1125574523.5025.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125574523.5025.10.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 01:35:23PM +0200, Arjan van de Ven wrote:

> +static unsigned int handle_roll(atomic_t *a)
> +{
> +	int x = atomic_read(a);
> +	if (x < 0) {
> +		atomic_set(a, 0);
> +		return 0;
> +	}
> +	return (unsigned int)x;
> +}
> 
> this is just plain scary.

Not really, it was just resetting atomic statistics counters when they
became negative.  Unecessary, though, so removed.

Dave

