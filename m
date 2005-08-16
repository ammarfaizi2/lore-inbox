Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVHPXuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVHPXuw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVHPXuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:50:52 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:19167 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750750AbVHPXup convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:50:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cUvOlFE5k7oWrgfhC85o99fxPn3LF0SjKrU8zy0UfJZ+eiCYWcEanLQQBChGasNcVbfZvOmr1S/noMzgHQP17PHIZwhZyIIQD2D8jmP90HwYxxnt5B9IQiHIBUfS9QOx9nhW6vB5CKcrYmYIN4qo+7MbeBpZnbxVtWwByDrcGpg=
Message-ID: <21d7e99705081616504d28cca5@mail.gmail.com>
Date: Wed, 17 Aug 2005 09:50:44 +1000
From: Dave Airlie <airlied@gmail.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: rc6 keeps hanging and blanking displays
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <20050816211424.GA14367@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42F89F79.1060103@aitel.hist.no>
	 <Pine.LNX.4.58.0508120937140.3295@g5.osdl.org>
	 <43008C9C.60806@aitel.hist.no>
	 <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org>
	 <20050815221109.GA21279@aitel.hist.no>
	 <21d7e99705081516182e97b8a1@mail.gmail.com>
	 <21d7e99705081516241197164a@mail.gmail.com>
	 <20050816165242.GA10024@aitel.hist.no>
	 <Pine.LNX.4.58.0508160955270.3553@g5.osdl.org>
	 <20050816211424.GA14367@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ...
> 
> Seems like it died trying to perform int10 initialization?

I'm still pointing towards that assign pci resources patch from Gregs
tree that I mentioned earlier..

the fact that disabling the DRM stops things from working is really
bad, maybe the pci_enable_device in the DRM is setting up the devices,
whereas  without it X tries and fails...

> 
> I can try running the radeon xserver only, as the vga console is on the matrox
> card.
> 

I'm running low on ideas, I'm also having a hard time tracking what is
actually happening,  the MGA bugs I've tracked are related to that
assign pci resources patch, and I really can't see what is happening
if the DRM isn't in the mix..

If you build a working kernel (i.e. like 2.6.13 without DRM) does it
hang similarly?

Dave.
