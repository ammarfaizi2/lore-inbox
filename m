Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbUJYRHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbUJYRHh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUJYRDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 13:03:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:44931 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262090AbUJYRCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:02:39 -0400
Date: Mon, 25 Oct 2004 19:02:16 +0200
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 2/17] Generic backward compatibility includes for 4level
Message-ID: <20041025170216.GA9142@wotan.suse.de>
References: <417CAA05.mail3Y411778M@wotan.suse.de> <20041025103926.A31632@flint.arm.linux.org.uk> <20041025160606.GA26306@verdi.suse.de> <1098723034.2798.35.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098723034.2798.35.camel@laptop.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 06:50:34PM +0200, Arjan van de Ven wrote:
> > > 
> > > Don't we normally add do { } while (0) after empty macros which look like
> > > a function?
> > 
> > iirc Rusty tried to come up with an example some time ago where it actually 
> > made a difference, but failed. But I can change it. 
> 
> 
> if (foo) 
> 	bar(); 
> else 
> 	pml4_ERROR(x);
> something_else();

Doesn't make any difference. Try it. With a double else it may make 
a difference, but that is extremly bad style imho and better resolved
with a {}. Also you'll get a clear compile error. 

-Andi
