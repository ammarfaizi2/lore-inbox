Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTEGG2m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 02:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbTEGG2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 02:28:42 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:13577 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261825AbTEGG2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 02:28:41 -0400
Date: Wed, 7 May 2003 07:41:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: dwmw2@infradead.org, thomas@horsten.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__ defined (trivial)
Message-ID: <20030507074111.A9109@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, dwmw2@infradead.org,
	thomas@horsten.com, linux-kernel@vger.kernel.org
References: <20030507072002.A7424@infradead.org> <20030506.221900.38693097.davem@redhat.com> <20030507072830.A7586@infradead.org> <20030506.222729.35034981.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030506.222729.35034981.davem@redhat.com>; from davem@redhat.com on Tue, May 06, 2003 at 10:27:29PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 10:27:29PM -0700, David S. Miller wrote:
>    From: Christoph Hellwig <hch@infradead.org>
>    Date: Wed, 7 May 2003 07:28:30 +0100
>    
>    rtnetlink.h is a bad example.  Just to use something you quoted earlier in
>    this thread..
>    
> What is wrong with it?  Truly kernel-only elements are protected
> with __KERNEL__ the rest are only the user visible and normal
> C types that are necessary for using rtnetlink in user apps.

If we have kernel declaration in those ABI headers you'd need an updated
abi-headers package for each change in one of your prototypes, rendering
it almost useless.

For this to work you really need two classes of headers, one the defines
ABIs and only ABIs and one that's for all kernel internal stuff.
