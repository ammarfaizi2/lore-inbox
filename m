Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVBWGjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVBWGjq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 01:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVBWGjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 01:39:45 -0500
Received: from waste.org ([216.27.176.166]:13212 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261342AbVBWGjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 01:39:44 -0500
Date: Tue, 22 Feb 2005 22:39:41 -0800
From: Matt Mackall <mpm@selenic.com>
To: "Bob O'Neill" <rmoneill@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reading the same entropy twice
Message-ID: <20050223063940.GD3163@waste.org>
References: <4b325ef050222135529a2584a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b325ef050222135529a2584a@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 04:55:39PM -0500, Bob O'Neill wrote:
> Hello.
> 
> I have noticed that it is possible on an SMP box for two processes to
> simultaneously read the same entropy out of /dev/urandom.  This
> doesn't seem right to me.  I was using the entropy value to generate a
> random number to use as a session ID, so occasionally there would be a
> collision on session IDs, causing a login failure as session IDs are
> required to be unique.  This issue does not appear to be related to
> entropy depletion.
> 
> Could you provide me with some insight into why this is the case, if
> it is intentional?  It seems like it could be addressed with a
> spinlock.

This should be fixed in current kernels.

-- 
Mathematics is the supreme nostalgia of our time.
