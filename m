Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272253AbRIKBto>; Mon, 10 Sep 2001 21:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272256AbRIKBtf>; Mon, 10 Sep 2001 21:49:35 -0400
Received: from t2.redhat.com ([199.183.24.243]:16638 "EHLO
	toomuch.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S272253AbRIKBtb>; Mon, 10 Sep 2001 21:49:31 -0400
Date: Mon, 10 Sep 2001 21:49:46 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Bao C. Ha" <baoha@sensoria.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Different old_mmap behavior between  2.4.5 and 2.4.8
Message-ID: <20010910214946.A16760@redhat.com>
In-Reply-To: <028701c13a61$67bf17e0$456c020a@SENSORIA>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <028701c13a61$67bf17e0$456c020a@SENSORIA>; from baoha@sensoria.com on Mon, Sep 10, 2001 at 06:30:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2001 at 06:30:55PM -0700, Bao C. Ha wrote:
> Is this supposed to be the correct behavior?  What changes 
> make the newer kernels to return different pointers?  We
> are running on the sh4 architecture but I think these calls
> come from malloc() which should be arch-independent.

The result from earlier kernels is wrong.  If your code 
requires that the same address is returned as was specified 
then you need to pass in the MAP_FIXED flag.

		-ben
