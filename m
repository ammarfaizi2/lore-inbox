Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277655AbRJLMPG>; Fri, 12 Oct 2001 08:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277654AbRJLMO4>; Fri, 12 Oct 2001 08:14:56 -0400
Received: from t2.redhat.com ([199.183.24.243]:25327 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S277644AbRJLMOp>; Fri, 12 Oct 2001 08:14:45 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <7202.1002886635@ocs3.intra.ocs.com.au> 
In-Reply-To: <7202.1002886635@ocs3.intra.ocs.com.au> 
To: Keith Owens <kaos@ocs.com.au>
Cc: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Modutils 2.5 change, start running this command now 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Oct 2001 13:14:41 +0100
Message-ID: <20283.1002888881@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
>  I was going to do it that way.  The problem is that it gives no
> indication if the module has been checked or not.  Adding
> EXPORT_NO_SYMBOLS says that somebody has reviewed the module and
> decided that exporting no symbols is the correct behaviour.  It is the
> difference between no maintainer and a maintained module. 

If all you want to know is whether modules are maintained or not, look to 
see how many have had MODULE_LICENSE(sic) tags added. 

Just change the default to no exported symbols, and a single depmod pass
will tell you what broke because it's no longer exporting symbols which are
required by something else. There's no need to add the EXPORT_NO_SYMBOLS
cruft all over the place.

Adding EXPORT_NO_SYMBOLS to those modules which don't need to export 
symbols doesn't make your task any easier - so please don't do it. Let's 
kill EXPORT_NO_SYMBOLS altogether.


--
dwmw2


