Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269056AbUJENp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269056AbUJENp5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 09:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269024AbUJENp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 09:45:57 -0400
Received: from mailsc1.simcon-mt.com ([195.27.129.236]:12857 "EHLO
	mailsc1.simcon-mt.com") by vger.kernel.org with ESMTP
	id S269088AbUJENpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 09:45:44 -0400
Date: Tue, 5 Oct 2004 15:47:53 +0200
From: "Andrei A. Voropaev" <av@simcon-mt.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: large auto variables cause segfault under 2.6
Message-ID: <20041005134753.GF28160@avorop.local>
References: <20041005132741.GD28160@avorop.local> <1096983652.9975.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096983652.9975.5.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 03:40:52PM +0200, Arjan van de Ven wrote:
> On Tue, 2004-10-05 at 15:27, Andrei A. Voropaev wrote:
> > Declaring very large auto variables cause segfaults in the program under
> > 2.6 kernel.
> > 
> > Take a look at this program.
> > 
> >   int main( int argc, char **argv )
> >   {
> >        unsigned char  bRet = 0;
> >   
> >        char tst[67123456];
> >   
> you have a stack variable that is several orders of magnitude bigger
> than the rlimit you have set for the stack I suspect. Try increasing the
> stack rlimit...
> 

Yep. I was just going to write "excuse me" letter. Looks like under new
kernel the kernel stack is limited to 8M while under 2.4 kernel it is
unlimited. So setrusage should help us.

Sorry for distractions.

Andrei


