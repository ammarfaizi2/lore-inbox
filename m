Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751243AbWFERoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWFERoQ (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 13:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWFERoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 13:44:15 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:11465 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1751243AbWFERoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 13:44:15 -0400
Date: Mon, 5 Jun 2006 10:44:14 -0700 (PDT)
From: dean gaudet <dean@arctic.org>
To: Joachim Fritschi <jfritschi@freenet.de>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH  4/4] Twofish cipher - x86_64 assembler
In-Reply-To: <200606051206.50085.jfritschi@freenet.de>
Message-ID: <Pine.LNX.4.64.0606051037540.6023@twinlark.arctic.org>
References: <200606041516.46920.jfritschi@freenet.de> <200606042110.15060.ak@suse.de>
 <200606051206.50085.jfritschi@freenet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006, Joachim Fritschi wrote:

> Here are the outputs from the tcrypt speedtests. They haven't changed much 
> since the last patch:
> 
> http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-c-i586.txt
> http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-asm-i586.txt
> http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-c-x86_64.txt
> http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-asm-x86_64.txt

when you quote anything related to cpu performance on an x86 processor 
it's absolutely essential to indicate which cpu it is... basically 
vendor_id, cpu family, and model from /proc/cpuinfo.  (for example the 
entire p4 family has incredible model-to-model variation on things like 
shifts and extensions.)


> > > +/* Defining a few register aliases for better reading */
> >
> > Maybe you can read it now better, but for everybody else it is extremly
> > confusing. It would be better if you just used the original register names.

i'd change the comment to:

/* define a few register aliases to simplify macro substitution */

because as you mention, it's totally impossible to write the macros 
otherwise.  (i've used the same trick myself a bunch of times.)

-dean
