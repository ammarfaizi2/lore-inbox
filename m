Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUBOTqh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 14:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbUBOTqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 14:46:37 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:58116 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265224AbUBOTqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 14:46:36 -0500
Date: Sun, 15 Feb 2004 19:46:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christophe Saout <christophe@saout.de>
Cc: Michal Kwolek <miho@centrum.cz>, jmorris@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
Message-ID: <20040215194633.A8948@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christophe Saout <christophe@saout.de>,
	Michal Kwolek <miho@centrum.cz>, jmorris@redhat.com,
	linux-kernel@vger.kernel.org
References: <402A4B52.1080800@centrum.cz> <1076866470.20140.13.camel@leto.cs.pocnet.net> <20040215180226.A8426@infradead.org> <1076870572.20140.16.camel@leto.cs.pocnet.net> <20040215185331.A8719@infradead.org> <1076873760.21477.8.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1076873760.21477.8.camel@leto.cs.pocnet.net>; from christophe@saout.de on Sun, Feb 15, 2004 at 08:36:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 15, 2004 at 08:36:00PM +0100, Christophe Saout wrote:
> The only reason, I guess, is that it depends on this very small
> dm-daemon thing:
> http://people.sistina.com/~thornber/dm/patches/2.6-unstable/2.6.2/2.6.2-udm1/00016.patch
> 
> Some other dm targets in the unstable tree use this too, it's just to
> have very simple bottom-half processing in a separate thread with
> synchronous start and stop functions.
> 
> Especially since dm-crypt was announced in a german linux magazine two
> weeks ago people keep asking me when to expect it in the kernel. And to
> delay it for some months just because there might be changes to
> dm-daemon, which would be almost trivial, is a stupid reason to hold it
> back if you ask me. :(

Well, actually the above code should not enter the kernel tree at all.
Care to rewrite dm-crypt to use Rusty's kthread code in -mm instead and
submit a patch to Andrew?  Whenever he merges the kthread stuff to mainline
he could just include dm-crypt then.
