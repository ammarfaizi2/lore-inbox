Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbVHKGBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbVHKGBD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 02:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbVHKGBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 02:01:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26556 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964804AbVHKGBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 02:01:00 -0400
Date: Thu, 11 Aug 2005 14:06:02 +0800
From: David Teigland <teigland@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050811060602.GA12438@redhat.com>
References: <20050802071828.GA11217@redhat.com> <1122968724.3247.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122968724.3247.22.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 09:45:24AM +0200, Arjan van de Ven wrote:

> * +	if (create)
> +		down_write(&ip->i_rw_mutex);
> +	else
> +		down_read(&ip->i_rw_mutex);
> 
> why do you use a rwsem and not a regular semaphore? You are aware that
> rwsems are far more expensive than regular ones right?  How skewed is
> the read/write ratio?

Rough tests show around 4/1, that high or low?

