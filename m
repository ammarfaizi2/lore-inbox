Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312294AbSCYETp>; Sun, 24 Mar 2002 23:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312295AbSCYETf>; Sun, 24 Mar 2002 23:19:35 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:2044 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S312294AbSCYETa>; Sun, 24 Mar 2002 23:19:30 -0500
Date: Sun, 24 Mar 2002 23:19:29 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tony.P.Lee@nokia.com, linux-kernel@vger.kernel.org
Subject: Re: mprotect() api overhead.
Message-ID: <20020324231928.A20764@redhat.com>
In-Reply-To: <4D7B558499107545BB45044C63822DDE3A2047@mvebe001.NOE.Nokia.com> <E16ob93-00019V-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2002 at 02:20:37AM +0000, Alan Cox wrote:
> > As for SMP case, for my application, it is less an issue, since
> > when user call my API in the .so, the mprotect (or that HP=20
> > 7 instructions) will open access to the share memory for them
> > regardless which CPU they are coming from.  If other thread
> 
> That still requires cross processor synchronization - so it will still
> take the same hit

It's actually an instruction on ia64, so the overhead is fairly low 
(similar to a cache miss).  That said, Linux doesn't have the ability 
to share portions of page tables between processes at present, so it 
doesn't matter.

		-ben
