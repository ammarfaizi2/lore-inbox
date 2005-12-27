Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVL0Hsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVL0Hsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 02:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVL0Hsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 02:48:43 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:54583 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932253AbVL0Hsm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 02:48:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L1n+uPejRmZPOcpFiglbFb9Duq4SOIQCgly9PaezbN1u3jLdVYcEkBrt2KqA9+DsBF2Nb2vpG2df37TQmw2asfHjP5u5RB9hPR4/ScwMxDVJdHh/vC7plPVr63LnqnsWjs3H6oIf3TNmBbCKEUapJ3dSEQgvxiZE77Xjwa1ZqT4=
Message-ID: <8e6f94720512262348l698c6cfbs28841f3f1dc989f1@mail.gmail.com>
Date: Tue, 27 Dec 2005 02:48:41 -0500
From: Will Dyson <will.dyson@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [BUG] Xserver startup locks system... git bisect results
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>,
       Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@linux.ie>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1134712343.6316.2.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051215043212.GA4479@jupiter.solarsys.private>
	 <1134622384.16880.26.camel@gaston> <1134623242.16880.30.camel@gaston>
	 <1134623748.16880.32.camel@gaston>
	 <17313.12671.661715.211100@cargo.ozlabs.ibm.com>
	 <20051216035032.GA4026@jupiter.solarsys.private>
	 <1134712343.6316.2.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> Finally fixes the radeon memory mapping bug that was incorrectly
> fixed by the previous patch. This time, we use the actual vram
> size as the size to calculate how far to move the AGP aperture
> from the framebuffer in card's memory space. If there are still
> issues with this patch, they are due to bugs in the X driver that
> I'm working on fixing too.

My amd64 machine with an agp radeon9200SE locks up tight on xserver
start (with an MCE) unless I revert both patches. I'm using x.org 6.9
compiled from the debian svn tree. The output of 'lspci -vv' is
available here:

http://www.lucidts.com/~will/lspcivv.txt

Please let me know of any testing I can do on x.org radeon DDX
patches, or any additional information I can provide.

--
Will Dyson
