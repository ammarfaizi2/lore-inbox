Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161294AbWFVUDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161294AbWFVUDl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 16:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161308AbWFVUDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 16:03:41 -0400
Received: from kevlar.burdell.org ([66.92.73.214]:34230 "EHLO
	kevlar.burdell.org") by vger.kernel.org with ESMTP id S1161294AbWFVUDj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 16:03:39 -0400
Date: Thu, 22 Jun 2006 16:03:37 -0400
From: Sonny Rao <sonny@burdell.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, anton@samba.org
Subject: Re: Possible bug in do_execve()
Message-ID: <20060622200337.GB9056@kevlar.burdell.org>
References: <20060620022506.GA3673@kevlar.burdell.org> <20060621184129.GB16576@sergelap.austin.ibm.com> <20060621185508.GA9234@kevlar.burdell.org> <20060621190910.GC16576@sergelap.austin.ibm.com> <20060621192726.GA10052@kevlar.burdell.org> <20060621194250.GD16576@sergelap.austin.ibm.com> <20060621201258.GB10052@kevlar.burdell.org> <20060622115907.GD27074@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622115907.GD27074@sergelap.austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 06:59:07AM -0500, Serge E. Hallyn wrote:
> Quoting Sonny Rao (sonny@burdell.org):
> > > > It seems to assume that mm->context is valid before doing a check.
> > > > 
> > > > Since I don't have a sparc64 box, I can't check to see if this
> > > > actually breaks things or not.
> > > 
> > > So we can either go through all arch's and make sure destroy_context is
> > > safe for invalid context, or split mmput() and destroy_context()...
> > > 
> > > The former seems easier, but the latter seems more robust in the face of
> > > future code changes I guess.
> > 
> > Yes, the former does seem easier, and perhaps easiest is to do that
> > and document what the pre-conditions are so future developers at least
> > have a clue.
> 
> Hmm, but document it where, since there is no single destroy_context()
> definition?  At the mmput() and __mmdrop() definitions in kernel/fork.c?
> 
That seems reasonable to me.  

I was hoping some of the arch maintainers might chime in with their
insight on the issue.  
