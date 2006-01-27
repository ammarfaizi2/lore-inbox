Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160998AbWA0UIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbWA0UIE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 15:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160999AbWA0UIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 15:08:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3778 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1160998AbWA0UID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 15:08:03 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060127092817.GB24362@infradead.org> 
References: <20060127092817.GB24362@infradead.org>  <1138312694656@2gen.com> <1138312695665@2gen.com> 
To: Christoph Hellwig <hch@infradead.org>
Cc: David H?rdeman <david@2gen.com>, linux-kernel@vger.kernel.org,
       dhowells@redhat.com, keyrings@linux-nfs.org
Subject: Re: [PATCH 01/04] Add multi-precision-integer maths library 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 27 Jan 2006 20:07:50 +0000
Message-ID: <6403.1138392470@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> This is ugly as hell.  If we decided to add it it really needs a major
> cleanup, fitting into linux style and removal of unused functionality,
> the assembly bits needs to move to an asm/ header, etc.

Which would make it harder to compare against the original, and so potentially
harder to track bug fixes in the original was my thinking.

> But to be honest I'd say anything that requires bigints shouldn't go into
> the kernel at all.  Could someone explain why they want dsa support in
> kernelspace?

Well... I'd like to revisit module signing at some point, though I imagine
it'll cause the LKML to melt again by those who think that I shouldn't have
the right to sign my modules because they imagine it impinges on their
rights:-) But I suspect the reason David wants this is so that he can encrypt
something with keys that he's not actually permitted to retrieve
directly. David?

David
