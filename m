Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbVIGWfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVIGWfm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 18:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVIGWfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 18:35:42 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:9405 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751312AbVIGWfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 18:35:41 -0400
Date: Wed, 7 Sep 2005 17:35:38 -0500
To: Dave Hansen <dave@sr71.net>
Cc: icampbell@arcom.com, PPC64 External List <linuxppc64-dev@ozlabs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] broken installkernel.sh with CROSS_COMPILE
Message-ID: <20050907223538.GF30028@austin.ibm.com>
References: <1125693554.26605.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125693554.26605.10.camel@localhost>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 01:39:13PM -0700, Dave Hansen was heard to remark:
> I noticed that my cross-compilation 'make install' broke with 2.6.13 (I
> don't use it horribly often).  It's from this commit:
> 
> Which added CROSS_COMPILE to each arch's install.sh:
> 
> if [ -x ~/bin/${CROSS_COMPILE}installkernel ]; then exec ~/bin/${CROSS_COMPILE}installkernel "$@"; fi
> 
> However, I don't just have a simple arch name as my CROSS_COMPILE, I
> have a whole path, so that line expands like this for me:

Try this:

# path to compilers and binutils, user may override by setting
# CROSS_PATH in environment
CROSS_PATH=${CROSS_PATH:-/opt/cross-3.3.2/bin}

CROSS_COMPILE=powerpc64-linux-

export PATH=$CROSS_PATH:$PATH

echo "using toolchain from $CROSS_PATH"


--linas
