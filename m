Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWDXVs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWDXVs1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWDXVs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:48:27 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17376 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751333AbWDXVs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:48:27 -0400
Subject: Re: Compiling C++ modules
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Avi Kivity <avi@argo.co.il>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <444D3D32.1010104@argo.co.il>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
	 <1145911546.1635.54.camel@localhost.localdomain>
	 <444D3D32.1010104@argo.co.il>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 22:58:38 +0100
Message-Id: <1145915918.1635.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-04-25 at 00:03 +0300, Avi Kivity wrote:
> Alan Cox wrote:
> I think it's easy to show that the equivalent C++ code would be shorter, 
> faster, and safer.

I've removed the poor guy from Iomega from the followups, perhaps others
could do likewise

Mathematically the answer is "no you couldn't". You might be able to
argue that a fortran implementation would be faster but not a C++ one.

And for strings C++ strings are suprisingly inefficient and need a lot
of memory allocations, which can fail and are not handled well without C
++ exceptions and other joyous language features you don't want in a
kernel. C with 'safe' string handling is similar - look at glib.

We have to make tradeoffs and the kernel tradeoffs have been to keep C
type fast string handling but to provide helpers in the hope people will
actually use them to avoid making mistakes.

