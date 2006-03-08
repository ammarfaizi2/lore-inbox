Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWCHU4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWCHU4W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWCHU4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:56:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24039 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932278AbWCHU4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:56:21 -0500
Date: Wed, 8 Mar 2006 12:54:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: david-b@pacbell.net, linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
       torvalds@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: Fw: Re: oops in choose_configuration()
Message-Id: <20060308125407.2cd5d829.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0603081539300.5360-100000@iolanthe.rowland.org>
References: <20060308121401.7926bf02.akpm@osdl.org>
	<Pine.LNX.4.44L0.0603081539300.5360-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:
>
> What about those scheduler changes you found through the bisection search?  
>  Any word on that?

Ingo's gone over them pretty closely.  The current theory is that the CPU
scheduler change alters timing sufficiently for the bug to bite.

The machine passes memtest86.

Ingo's suspecting stack corruption.  Do you know whether USB anywhere does
DMA into automatically-allocated storage (ie: kernel stacks)?

Am about to reboot into a stack-corruption-detector patch from Ingo.

