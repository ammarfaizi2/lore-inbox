Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbUJ1U2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbUJ1U2D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 16:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbUJ1UUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 16:20:42 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:49936 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262185AbUJ1UTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 16:19:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=D162lLdUjPUlMKDVn3n+EoFXO6P1EhvT3Lvyu5euo9efTE5VVTkHCwBj7p6R4ykO18odD3tylywB+fU4J91ZCnKDqOoU1R07lPdaAztnLlYQJ8KhZR8tjDMuu4o7fLguQgM7IHU+dEqKlFTHBlkj7P6iYTRyACht1eWZ4s1AV1Y=
Message-ID: <311601c90410281319596a1ec1@mail.gmail.com>
Date: Thu, 28 Oct 2004 14:19:32 -0600
From: Eric Mudama <edmudama@gmail.com>
Reply-To: Eric Mudama <edmudama@gmail.com>
To: gene.heskett@verizon.net
Subject: Re: [BK PATCHES] ide-2.6 update
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: <200410271458.17499.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410271213_MC3-1-8D44-F2D8@compuserve.com>
	 <1098893896.4304.23.camel@localhost.localdomain>
	 <200410271458.17499.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of two things is happening:

1) Two drives are identically corrupted, producing the invalid serial
numbers being reported in the ID block.  My belief is that this wasn't
likely, given the low volume of reports.  The reported bad SN was
"M0000000000000000000" which based on our firmware, I don't see how it
could happen.  A corruption of the config sector (the most likely
cause) *should* be catastrophic to the drive's functionality.

2) There is a code or hardware bug somewhere outside of the drive
itself that is causing this data to become corrupted.

Either way, I believe the best course of action is to RMA the drives
for new ones.  I don't think good stuff will come from having the
linux kernel use drives that appear to be broken.

It'd be nice to test these drives on more systems, or with a bus
analyzer, to identify the cause.

--eric






On Wed, 27 Oct 2004 14:58:17 -0400, Gene Heskett
<gene.heskett@verizon.net> wrote:
> On Wednesday 27 October 2004 12:18, Alan Cox wrote:
> >On Mer, 2004-10-27 at 17:10, Chuck Ebbert wrote:
> >>         - accept bad Maxtor drive serial number
> >
> >This should not be applied. If your drive is no longer reporting its
> >serial number then its faulty.
> 
> ISTR he wrote that he had 2 (identical?) drives that were reporting
> the same serial number.  Somewhat, but not exactly like I have two
> different epson printers, both usb driven, and which except for the
> reported serial number, return otherwise identical data when queried
> by the usb drivers during dmesg.  Which I find odd because one is a
> C82, 4 color model, and the other is a Photo 820, 6 color model.
