Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261712AbSI0Q4B>; Fri, 27 Sep 2002 12:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261714AbSI0Q4A>; Fri, 27 Sep 2002 12:56:00 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:24074 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261712AbSI0Qz7>; Fri, 27 Sep 2002 12:55:59 -0400
Date: Fri, 27 Sep 2002 18:01:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38
Message-ID: <20020927180118.A32610@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <20020927003210.A2476@sgi.com> <20020926225147.GC7304@kroah.com> <20020927174849.A32207@infradead.org> <20020927165556.GH11530@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020927165556.GH11530@kroah.com>; from greg@kroah.com on Fri, Sep 27, 2002 at 09:55:56AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 09:55:56AM -0700, Greg KH wrote:
> For cases like the module_* hooks, and the other examples you pointed
> out, I agree.
> 
> For other cases, capable() is just not fine grained enough to actually
> know what is going on (like CAP_SYS_ADMIN).  In those cases you need an
> extra hook to determine where in the kernel you are.

Either we make capable fine grained enough (64 or 128bit capability
vectors, I have some old code for that around and I know SGI used that
more than a year ago) or we replace the capable in those cases with hooks
entirely.

