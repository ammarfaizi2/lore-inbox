Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUDEOp7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 10:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbUDEOp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 10:45:59 -0400
Received: from mail.cyclades.com ([64.186.161.6]:18096 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262756AbUDEOpc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 10:45:32 -0400
Date: Mon, 5 Apr 2004 11:22:02 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Matt Brown <matt@mattb.net.nz>
Cc: kernel@linuxace.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, dlstevens@ibm.com, davem@redhat.com
Subject: Re: Kernel panic in 2.4.25
Message-ID: <20040405142202.GB12470@logos.cnet>
References: <1081129354.1611.44.camel@argon.shr.crc.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081129354.1611.44.camel@argon.shr.crc.net.nz>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 01:42:34PM +1200, Matt Brown wrote:
> > IIRC a similar problem was in v2.6.
> >
> > I'll dig it up.
> 
> Was any progress made on this problem?
> 
> I am seeing the same panic as was originally reported using both kernel
> 2.4.25 and 2.4.26-rc1, I can easily reproduce it under the same
> conditions as Hasso described in the original email. 
> 
> With quagga/ospfd running I simply execute
> ifconfig eth0 down
> ifconfig eth0 up 
> in quick succession and a panic follows within 20 seconds. 
> 
> The panic does not occur if ospfd is not running, or if i pause for at
> least 10 seconds between the two commands. 
> 
> Let me know if I can provide any more information that would be helpful
> in solving this problem. 

Matt,

This oops should be fixed by

http://linux.bkbits.net:8080/linux-2.4/patch@1.1342?nav=index.html|ChangeSet@-7d|cset@1.1342

Which will be part of 2.4.26-rc2. Please try it.
