Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261661AbSKCF6u>; Sun, 3 Nov 2002 00:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261665AbSKCF6t>; Sun, 3 Nov 2002 00:58:49 -0500
Received: from rth.ninka.net ([216.101.162.244]:28377 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261661AbSKCF6q>;
	Sun, 3 Nov 2002 00:58:46 -0500
Subject: Re: invalid character 45 in exportstr for include-config
From: "David S. Miller" <davem@redhat.com>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>
In-Reply-To: <20021103031835.Q20749@parcelfarce.linux.theplanet.co.uk>
References: <20021103031835.Q20749@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Nov 2002 22:20:11 -0800
Message-Id: <1036304411.17126.1.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-02 at 19:18, Matthew Wilcox wrote:
> Anyone else seeing this error message?  I figured out what it _actually_
> means is that the character `-' is not permitted in the symbol being
> exported.  so if we change include-config to include_config in Makefile
> and scripts/Makefile.build, everything is fine.
> 
> How about the following patch?

Nice work Matthew, although you missed cleaning up a few remaining
'include-config' references in comments.

Kai, this fixes the problem I reported to you on sparc64 with
make-3.79   What version of make do you have which accepted this
variable name with a dash in it?

