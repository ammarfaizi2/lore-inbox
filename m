Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWHVPh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWHVPh7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 11:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWHVPh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 11:37:59 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59077 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932318AbWHVPh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 11:37:58 -0400
Subject: Re: [PATCH] paravirt.h
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
In-Reply-To: <44EB1BEB.60202@goop.org>
References: <1155202505.18420.5.camel@localhost.localdomain>
	 <44DB7596.6010503@goop.org>
	 <1156254965.27114.17.camel@localhost.localdomain> <44EB1BEB.60202@goop.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Aug 2006 16:58:13 +0100
Message-Id: <1156262293.27114.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-22 am 07:59 -0700, ysgrifennodd Jeremy Fitzhardinge:
> out, nothing is actually read-only in the kernel when using a 2M 
> mapping.  It's also ameliorated by the fact that some of the entrypoints 

Thats a loader problem. It ties directly in with things like relocatable
kernels. Arjan has been systematically working to get us "const" objects
and that needs to continue, and the more we can enforce it the more
security we get and the more bugs we catch.

It's also a mistake to assume the read-only doesn't help. Your 2MB
sections penalty isnt true in a virtualised environment.

Alan

