Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751156AbWFEOsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWFEOsb (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 10:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWFEOsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 10:48:30 -0400
Received: from canuck.infradead.org ([205.233.218.70]:32739 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751156AbWFEOs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 10:48:29 -0400
Subject: Re: [PATCH] Use ld's garbage collection feature
From: David Woodhouse <dwmw2@infradead.org>
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <20060605143636.GB2878@dmt>
References: <20060605003152.GA1364@dmt>
	 <1149501822.30024.59.camel@pmac.infradead.org>  <20060605143636.GB2878@dmt>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 15:48:25 +0100
Message-Id: <1149518905.30024.142.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 11:36 -0300, Marcelo Tosatti wrote:
> On Mon, Jun 05, 2006 at 11:03:42AM +0100, David Woodhouse wrote:
> > On Sun, 2006-06-04 at 21:31 -0300, Marcelo Tosatti wrote:
> > > +cflags-$(CONFIG_GCSECTIONS) += -ffunction-sections
> > 
> > Any reason you didn't also use -fdata-sections? 
> 
> Not really - will try. 

Btw, I filed two gcc bugs for the (first) things which prevent us from
building stuff like filesystems with something like 
'gcc -fwhole-program --combine fs/jffs2/*.c'

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=27898
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=27899

-- 
dwmw2

