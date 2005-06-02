Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVFBJ0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVFBJ0t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 05:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVFBJ0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 05:26:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9347 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261305AbVFBJ0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 05:26:44 -0400
Date: Thu, 2 Jun 2005 17:30:21 +0800
From: David Teigland <teigland@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 6/9] dlm: clear recovery flags
Message-ID: <20050602093021.GL21570@redhat.com>
References: <20050602080301.GF21570@redhat.com> <1117700360.6458.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117700360.6458.25.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 10:19:20AM +0200, Arjan van de Ven wrote:
> On Thu, 2005-06-02 at 16:03 +0800, David Teigland wrote:
> > +	clear_bit(LSFL_LOCKS_VALID, &ls->ls_flags);
> > +	clear_bit(LSFL_ALL_LOCKS_VALID, &ls->ls_flags);
> >  	clear_bit(LSFL_DIR_VALID, &ls->ls_flags);
> >  	clear_bit(LSFL_ALL_DIR_VALID, &ls->ls_flags);
> >  	clear_bit(LSFL_NODES_VALID, &ls->ls_flags);
> 
> btw do these need to be atomic? right now these are atomic ops and thus
> very expensive... you might want to switch to nonatomic variants if
> that's not needed.

No they don't, I didn't know about the __ non-atomics.  I'll go through
and switch, thanks.

Dave

