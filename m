Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265736AbUGNHIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265736AbUGNHIh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 03:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbUGNHIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 03:08:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:35500 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265736AbUGNHIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 03:08:36 -0400
Date: Wed, 14 Jul 2004 00:07:00 -0700
From: Greg KH <greg@kroah.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [RFC] Refcounting of objects part of a lockfree collection
Message-ID: <20040714070700.GA12579@kroah.com>
References: <20040714045345.GA1220@obelix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714045345.GA1220@obelix.in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 10:23:50AM +0530, Ravikiran G Thirumalai wrote:
> 
> The attatched patch provides infrastructure for refcounting of objects
> in a rcu protected collection.

This is really close to the kref implementation.  Why not just use that
instead?

Oh, and I think you need to use atomic_set() instead of initializing the
atomic_t by hand.

thanks,

greg k-h
