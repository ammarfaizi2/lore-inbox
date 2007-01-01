Return-Path: <linux-kernel-owner+w=401wt.eu-S932920AbXAAG7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932920AbXAAG7N (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 01:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932923AbXAAG7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 01:59:12 -0500
Received: from smtp-out.google.com ([216.239.33.17]:28187 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932920AbXAAG7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 01:59:10 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=SfDxpUd4nXcPMsmuglZvAGdM39HJTeSvinm7gJ9Ikpprp6o//LYdO/iQpM1VePvlz
	7mDti+bJxmkFAhQw5eg+g==
Message-ID: <65dd6fd50612312258i3bea1928m3d06c04fdbb5a7c@mail.gmail.com>
Date: Sun, 31 Dec 2006 22:58:59 -0800
From: "Ollie Wild" <aaw@google.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [patch] remove MAX_ARG_PAGES
Cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Arjan van de Ven" <arjan@infradead.org>, linux-mm@kvack.org,
       "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@muc.de>,
       linux-arch@vger.kernel.org, "David Howells" <dhowells@redhat.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>
In-Reply-To: <20061229200357.GA5940@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <65dd6fd50610101705t3db93a72sc0847cd120aa05d3@mail.gmail.com>
	 <1160572460.2006.79.camel@taijtu>
	 <65dd6fd50610111448q7ff210e1nb5f14917c311c8d4@mail.gmail.com>
	 <65dd6fd50610241048h24af39d9ob49c3816dfe1ca64@mail.gmail.com>
	 <20061229200357.GA5940@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> what is keeping this fix from going upstream?
>

There are still a couple outstanding issues which need to be resolved
before this is ready for inclusion in the mainline kernel.

The main one is support for CONFIG_STACK_GROWSUP, which I think is
just parisc.  I've been meaning to look into this for a while, but I
was out of commision for most of November so it got punted to the back
burner.  I'll try to revisit it soonish.  If someone from the
parisc-linux list wants to take a look, though, that's fine by me.

The other is support for the various executable formats.  I've tested
elf and script pretty thoroughly, but I'm not sure how to go about
testing most of the others -- does anyone use aout anymore?  Maybe the
solution is just to check it in and wait to see if someone complains.

Ollie
