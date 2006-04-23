Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWDWS5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWDWS5e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 14:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWDWS5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 14:57:34 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:42602 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751119AbWDWS5d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 14:57:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nqo7jA2k2CVYi1IH+TS9MmfmC8CwN0yKbtnEqKFwtjOJO2D8DqtIbKgFezRcE9B0PZ59/Y7wgzyPVgIFNr1vbNl0lfRh3lHFTtnKGzBtz3vWX5zns8+jL+LUO7KkmKMx6Dxy7cObyqxahoVON8PYL8wnnbyHufIr4+nf10bQxIs=
Message-ID: <cda58cb80604231157g58088e0dhb93a91c46deda627@mail.gmail.com>
Date: Sun, 23 Apr 2006 20:57:30 +0200
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "Nicolas Pitre" <nico@cam.org>
Subject: Re: How can I prevent MTD to access the end of a flash device ?
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0604231323180.3603@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cda58cb80511070248o6d7a18bex@mail.gmail.com>
	 <cda58cb80511220658n671bc070v@mail.gmail.com>
	 <Pine.LNX.4.64.0511221042560.6022@localhost.localdomain>
	 <cda58cb80604231006x4911598bg6c1e3d62f07d80e7@mail.gmail.com>
	 <Pine.LNX.4.64.0604231323180.3603@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/4/23, Nicolas Pitre <nico@cam.org>:
> On Sun, 23 Apr 2006, Franck Bui-Huu wrote:
> >
> > Your advice seems fine, but it brings some restrictions on flash
> > concatenations: for example, if I have 2 flashes of 32Mbytes, I need
> > to create 2 partitions whose sizes are 32M - 64K bytes but then I
> > can't concatenate these two partitions anymore since concatenation
> > works with mtd devices, not partitions, does it ?
>
> MTD partitions are MTD "devices" as well.
>

well, mtd_concat_create() functions doesn't use MTD partitions...and
what's happening if the user needs to use its own partitions based on
a device resulting of several concatenated flashes? It migth be
possible to still use your solution and just fix user partitions but
it really seems easier to fix the MTD size after it the flash has been
probed.

Do you think it's possible to change the size of a mtd device rigth
after probing it ?

Thanks
--
               Franck
