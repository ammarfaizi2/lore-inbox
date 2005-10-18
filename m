Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVJRPbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVJRPbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 11:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVJRPbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 11:31:10 -0400
Received: from qproxy.gmail.com ([72.14.204.199]:48419 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750737AbVJRPbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 11:31:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Eo9c14YPdFJh/Dah8GS2rFxhGw8i9nBgvWD7Qoun3P4oWoibpsa890UszqT2gMYidLOD3J2TmjaXusEs6CmOKGIQfYGuqsQBeR9VXW53pptaEbZeOG82XoOOg1pvHn1S6L/hsI4q8jxd14ThF8bEkekY1TVdOhDKqaiiBaj1gyc=
Subject: Re: file system block size
From: Badari Pulavarty <pbadari@gmail.com>
To: Bob Copeland <email@bobcopeland.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Roushan Ali <roushan.ali@gmail.com>,
       Nathan Scott <nathans@sgi.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <b6c5339f0510180812p3ff6d0b1ia204b28c4e50186d@mail.gmail.com>
References: <30b4e63b0510172252x1dfca9f2l75bb0f183aecf7bb@mail.gmail.com>
	 <20051019001218.B5830881@wobbly.melbourne.sgi.com>
	 <1129646212.15136.37.camel@imp.csi.cam.ac.uk>
	 <b6c5339f0510180812p3ff6d0b1ia204b28c4e50186d@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 18 Oct 2005 08:30:24 -0700
Message-Id: <1129649424.23632.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 11:12 -0400, Bob Copeland wrote:
> > Indeed, it makes everything harder.  Have a look at ntfs in the kernel
> > which has to cope with file system block sizes between 512 bytes and
> > several hundred kiB (at least they are in powers of two thank
> > goodness...).  You end up not being able to use a lot of generic
> > functions as you for example need to lock multiple pages which needs to
> > be ordered correctly, etc...  If you look at the latest -mm kernel, the
> > ntfs driver there has file write(2) support for any cluster size and you
> > will see an example of the multiple page locking problem solution there.
> 
> Any chance this will make it into common code?  I also need it for my
> filesystem driver (here: http://bobcopeland.com/karma/).  So far I've
> only done read side which is not too bad, but as you say writing makes
> things complicated.
> 
> That, and the extent-supporting mpage_readpages would make me a happy person.

Can you elaborate ? What would you like to see in mpage_readpages() ?
Christoph recently posted patches to add support for getblocks() in
mpage_readpages().  What else do you need ?


Thanks,
Badari

