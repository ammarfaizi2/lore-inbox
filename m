Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWGMPKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWGMPKZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 11:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWGMPKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 11:10:25 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:29277 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030207AbWGMPKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 11:10:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O26nffzEGazYufoVOuNy55XglxR1YAtNu/7x6HLq44VCPDB07X02X71ENZ21LYJcuOaUBAcVju3Dv3Grxl6VGjKIaX4zCRbtQEdsBzLbI30gc8mn/DO2mpSgSx18eJAVSpRIGZP/VYjMbdTZOHwxe+G6TyM9Ox1zpK2zuIzpwew=
Message-ID: <62b0912f0607130810w5fd768f6k19294f3fafb42dc3@mail.gmail.com>
Date: Thu, 13 Jul 2006 17:10:24 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: wine-devel@winehq.org
Subject: Re: "assumed" graphic card memory
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200607121719.14528.ns03ja@brocku.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060711162356.GK11322@byleth.sc-networks.de>
	 <62b0912f0607121326s428ceb57h2fae8f1e9855acb6@mail.gmail.com>
	 <200607121719.14528.ns03ja@brocku.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd say it needs a framebuffer device which I do not have

Use the PCI variant ;-).

> Also, the PCI path varies a lot

Obviously.  The correct PCI path would need to be found first.

(I used "lspci|grep VGA", hehe.)

> None of this works at all on non-Linux systems, for that matter.
> (Wine does run on non-Linux systems, in case you didn't realize that.)

Default to 64MB on those systems.

> This reports the wrong values for me in
> one machine with a 32M video card:
> 134217728

Ok.  Guess it's rubbish then, too bad.
Oh well.

> It might be possible to guesstimate the available memory:
> http://delphi3d.net/articles/viewarticle.php?article=texman.htm

Promising!

But perhaps an easier approach would be to fix every Linux driver
to report the correct number in sysfs.  I'm pretty sure each driver
knows how much RAM is on the card already, so it should be trivial..
