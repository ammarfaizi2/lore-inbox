Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbUJYUYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbUJYUYU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbUJYUXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:23:55 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:38751 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261275AbUJYUL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:11:29 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 07/10] uml: kbuild - add even more cleaning
Date: Mon, 25 Oct 2004 22:11:22 +0200
User-Agent: KMail/1.6.1
Cc: Chris Wedgwood <cw@f00f.org>, akpm@osdl.org, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
References: <20041012001759.317908695@zion.localdomain> <20041025084308.GA19935@taniwha.stupidest.org>
In-Reply-To: <20041025084308.GA19935@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410252211.22562.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 October 2004 10:43, Chris Wedgwood wrote:
> On Tue, Oct 12, 2004 at 02:17:59AM +0200, blaisorblade_spam@yahoo.it wrote:
> >  MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
> > -	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS))
> > +	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os
>
> these sorts of rules don't work when doing "make O=build ARCH=um ..."
Yes, they do as much as they can.  Kbuild cd's to the objtree before doing 
anything. Specifying $(objtree) is not needed. Specifying $(obj) probably 
does not even work in the ARCH Makefile.

That said, O=<whatever> is highly broken; it seems that Gerd Knorr was able to 
build the tree with O=, but actually some files are still created in the 
source tree, while they should not. This is a problem and would require 
various changes.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
