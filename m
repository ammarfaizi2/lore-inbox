Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261601AbSI0QwP>; Fri, 27 Sep 2002 12:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261608AbSI0QwP>; Fri, 27 Sep 2002 12:52:15 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:44557 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261601AbSI0QwO>;
	Fri, 27 Sep 2002 12:52:14 -0400
Date: Fri, 27 Sep 2002 09:55:56 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38
Message-ID: <20020927165556.GH11530@kroah.com>
References: <20020927003210.A2476@sgi.com> <20020926225147.GC7304@kroah.com> <20020927174849.A32207@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020927174849.A32207@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 05:48:49PM +0100, Christoph Hellwig wrote:
> > capable is needed to be checked, as we are not modifying the existing
> > permission logic.
> 
> I odn't think it makes sense to have two security checks that both
> end up in the LSM code after each other..

For cases like the module_* hooks, and the other examples you pointed
out, I agree.

For other cases, capable() is just not fine grained enough to actually
know what is going on (like CAP_SYS_ADMIN).  In those cases you need an
extra hook to determine where in the kernel you are.

thanks,

greg k-h
