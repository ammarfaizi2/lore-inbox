Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWCJDgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWCJDgg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 22:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWCJDgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 22:36:36 -0500
Received: from smtp-out.google.com ([216.239.45.12]:6433 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750788AbWCJDgf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 22:36:35 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=DmabPt09MPDu4jK5SuYQWpsv7EizUy2npjQOSG40lNDHu74/IzX5u5xANZwGQVAHD
	f4leCozmZksvGjSWM6GZg==
Message-ID: <545d88bc0603091936i5c25c065ne8e31ca23e9473f4@mail.google.com>
Date: Thu, 9 Mar 2006 19:36:25 -0800
From: dkegel <dkegel@google.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 1/1] x86: Make _syscallX() macros compile in PIC mode on i386
Cc: "Markus Gutschke" <markus@google.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060309192232.2fd4767c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4410BB32.1020905@google.com>
	 <20060309184759.591e3551.akpm@osdl.org> <4410EC8A.4020808@google.com>
	 <20060309192232.2fd4767c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/06, Andrew Morton <akpm@osdl.org> wrote:
> I doubt if glibc is borrowing the kernel's macros.

I think it is, though.

When I build gcc/glibc toolchains, I have to use kernel headers.
I used to directly use the ones in the kernel.org tree, but
those aren't quite intended for use in userspace; fortunately,
Mariusz Mazur's sanitized kernel headers work great.

I'd like to see these patches go in to the sanitized kernel headers
and/or the kernel.org tree.  I imagine that putting them in the kernel.org
tree is right, and they'd naturally percolate from there to the
various sanitized headers projects.

See also http://lkml.org/lkml/2006/1/7/51
- Dan
