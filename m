Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVIGWx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVIGWx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 18:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVIGWx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 18:53:57 -0400
Received: from blackbird.sr71.net ([64.146.134.44]:12213 "EHLO
	blackbird.sr71.net") by vger.kernel.org with ESMTP id S932212AbVIGWx5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 18:53:57 -0400
Subject: Re: [RFC] broken installkernel.sh with CROSS_COMPILE
From: Dave Hansen <dave@sr71.net>
To: linas <linas@austin.ibm.com>
Cc: icampbell@arcom.com, PPC64 External List <linuxppc64-dev@ozlabs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050907223538.GF30028@austin.ibm.com>
References: <1125693554.26605.10.camel@localhost>
	 <20050907223538.GF30028@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 15:53:51 -0700
Message-Id: <1126133631.6354.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-07 at 17:35 -0500, linas wrote:
> On Fri, Sep 02, 2005 at 01:39:13PM -0700, Dave Hansen was heard to remark:
> > I noticed that my cross-compilation 'make install' broke with 2.6.13 (I
> > don't use it horribly often).  It's from this commit:
> > 
> > Which added CROSS_COMPILE to each arch's install.sh:
> > 
> > if [ -x ~/bin/${CROSS_COMPILE}installkernel ]; then exec ~/bin/${CROSS_COMPILE}installkernel "$@"; fi
> > 
> > However, I don't just have a simple arch name as my CROSS_COMPILE, I
> > have a whole path, so that line expands like this for me:
> 
> Try this:
> 
> # path to compilers and binutils, user may override by setting
> # CROSS_PATH in environment
> CROSS_PATH=${CROSS_PATH:-/opt/cross-3.3.2/bin}
> 
> CROSS_COMPILE=powerpc64-linux-
> 
> export PATH=$CROSS_PATH:$PATH
> 
> echo "using toolchain from $CROSS_PATH"

I'm not sure I understand.  Where should that be done?

-- Dave

