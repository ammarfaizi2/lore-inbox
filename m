Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbUKIJnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbUKIJnE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 04:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUKIJlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 04:41:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:41697 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261461AbUKIJjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 04:39:52 -0500
Date: Tue, 9 Nov 2004 01:39:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: arjan@infradead.org, olivier@pas-tres.net, linux-kernel@vger.kernel.org,
       Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
       diffie@blazebox.homeip.net, greg@kroah.com, diffie@gmail.com
Subject: Re: 2.6.10-rc1-mm3
Message-Id: <20041109013913.021d63d6.akpm@osdl.org>
In-Reply-To: <20041109103733.GA15065@elte.hu>
References: <9dda349204110611043e093bca@mail.gmail.com>
	<20041107024841.402c16ed.akpm@osdl.org>
	<20041108075934.GA4602@elte.hu>
	<20041107234225.02c2f9b6.akpm@osdl.org>
	<20041108224259.GA14506@kroah.com>
	<20041108212747.33b6e14a.akpm@osdl.org>
	<792238A4-3224-11D9-9F1E-000D934362B4@pas-tres.net>
	<1099988562.3989.4.camel@laptop.fenrus.org>
	<20041109103733.GA15065@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> * Arjan van de Ven <arjan@infradead.org> wrote:
> 
>  > On Tue, 2004-11-09 at 08:53 +0100, Olivier Poitrey wrote:
>  > > On 9 nov. 04, at 06:27, Andrew Morton wrote:
>  > > 
>  > > > [...] Is there a requirement to support more than 256 legacy ptys?
>  > > 
>  > > Yes it is. For big vserver hosting systems for instance, running like
>  > > 100 vservers per node you can easily hit this limit.
>  > 
>  > but do you really need the legacy pty's for that instead of the
>  > "modern" ones ?
> 
>  probably not, but if the fix is easy then there's no reason not to do
>  it.

We'd have to cook up a new naming scheme for them.  And hotplug scripts
to create the device nodes.  Except hotplug probably isn't running correctly
at that time.  My RH system here only comes with 256 /dev/pty* device nodes.
