Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161169AbVICIui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161169AbVICIui (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 04:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVICIui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 04:50:38 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:1003 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751206AbVICIuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 04:50:37 -0400
Subject: Re: [RFC] broken installkernel.sh with CROSS_COMPILE
From: Ian Campbell <icampbell@arcom.com>
To: Dave Hansen <dave@sr71.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PPC64 External List <linuxppc64-dev@ozlabs.org>
In-Reply-To: <1125693554.26605.10.camel@localhost>
References: <1125693554.26605.10.camel@localhost>
Content-Type: text/plain
Organization: Arcom Control Systems Ltd.
Date: Sat, 03 Sep 2005 09:50:20 +0100
Message-Id: <1125737431.6565.88.camel@azathoth.hellion.org.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-02 at 13:39 -0700, Dave Hansen wrote:
> I noticed that my cross-compilation 'make install' broke with 2.6.13 (I
> don't use it horribly often).  It's from this commit:
> 
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=0f8e2d62fa04441cd12c08ce521e84e5bd3f8a46
> 
> Which added CROSS_COMPILE to each arch's install.sh:
> 
> if [ -x ~/bin/${CROSS_COMPILE}installkernel ]; then exec ~/bin/${CROSS_COMPILE}installkernel "$@"; fi
> 
> However, I don't just have a simple arch name as my CROSS_COMPILE, I
> have a whole path

Ah, I didn't consider that case, sorry.

> , so that line expands like this for me:
> 
> + '[' -x /home/dave/bin//home/services/cross_compile/ppc64/bin/ppc64-linux-gnu-installkernel ']'
> 
> Needless to say, that doesn't work :)
> 
> Could we do something that's guaranteed to not have lots of extra path
> elements in it, like ARCH?

Or perhaps basename ${CROSSCOMPILE}?

Ian.

-- 
Ian Campbell

Campbell's Law:
	Nature abhors a vacuous experimenter.

