Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVANKij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVANKij (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 05:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVANKij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 05:38:39 -0500
Received: from colin2.muc.de ([193.149.48.15]:3845 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261939AbVANKii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 05:38:38 -0500
Date: 14 Jan 2005 11:38:36 +0100
Date: Fri, 14 Jan 2005 11:38:36 +0100
From: Andi Kleen <ak@muc.de>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050114103836.GA71397@muc.de>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de> <m17jmg2tm8.fsf@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17jmg2tm8.fsf@clusterfs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 01:27:27PM +0300, Nikita Danilov wrote:
> Andi Kleen <ak@muc.de> writes:
> 
> [...]
> 
> >
> > Preferably that would be only the fastest options (extremly simple
> > per CPU buffer with inlined fast path that drop data on buffer overflow), 
> 
> Logging mechanism that loses data is worse than useless. It's only too
> often that one spends a lot of time trying to reproduce some condition
> with logging on, only to find out that nothing was logged.

When you have a timing bug and your logger starts to block randomly
you also won't debug anything. Fix is to make your buffers bigger.

-Andi
