Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbUKNFHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbUKNFHg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 00:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUKNFHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 00:07:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:55510 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261246AbUKNFHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 00:07:32 -0500
Date: Sat, 13 Nov 2004 21:07:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH] VM routine fixes 
In-Reply-To: <20942.1100257558@redhat.com>
Message-ID: <Pine.LNX.4.58.0411132105240.12386@ppc970.osdl.org>
References: <20041112023817.247af548.akpm@osdl.org>  <20041111143148.76dcaba4.akpm@osdl.org>
 <200411081432.iA8EWfmh023432@warthog.cambridge.redhat.com> <19844.1100255635@redhat.com>
  <20942.1100257558@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Nov 2004, David Howells wrote:
> 
> vm_area_struct not having an ops member? There's no real need for ops on
> uClinux since almost all of the ops are irrelevant.

I don't think that is a valid argument.

If uClinux wants to be a different source-base, then go wild. But if you 
want to integrate into the standard kernel, there are other priorities. 
One of them is that it has to integrate cleanly. And that means that we 
don't do micro-optimizations that make the non-MMU case affect mainline 
code unless there is a damn good reason.

		Linus
