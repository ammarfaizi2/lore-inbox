Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261526AbSI0Qnc>; Fri, 27 Sep 2002 12:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261562AbSI0Qnc>; Fri, 27 Sep 2002 12:43:32 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:17930 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261526AbSI0Qnb>; Fri, 27 Sep 2002 12:43:31 -0400
Date: Fri, 27 Sep 2002 17:48:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38
Message-ID: <20020927174849.A32207@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <20020927003210.A2476@sgi.com> <20020926225147.GC7304@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020926225147.GC7304@kroah.com>; from greg@kroah.com on Thu, Sep 26, 2002 at 03:51:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 03:51:48PM -0700, Greg KH wrote:
> > leave the capable in and say it's enough or you add your random hook
> > and remove that one.  Just adding more and more hooks without thinking
> > gets us exactly nowhere except to an unmaintainable codebase.
> 
> capable is needed to be checked, as we are not modifying the existing
> permission logic.

I odn't think it makes sense to have two security checks that both
end up in the LSM code after each other..

