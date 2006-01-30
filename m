Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWA3XsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWA3XsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 18:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbWA3XsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 18:48:09 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:59453 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965044AbWA3XsI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 18:48:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lBs73+JghYuWi5avGxXmUuZjPG/MQhMxswMJ3NycE13mjhT3CerZxlahLmXucF3GVAGhv2i3/swmWpix08F/nSqdvUfJV2RCYnaclAR6ZQq+AObpeq3c43H8DLtws945j6tniKVYwhEkIR4G3WYx9gXW2qDIrCPiUOpAaT5FjJs=
Message-ID: <32e47b670601301548w36482c78n2119f8a78ae68ce0@mail.gmail.com>
Date: Mon, 30 Jan 2006 18:48:05 -0500
From: Sai Bathina <sai.bathina@gmail.com>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Subject: Re: 2.6.14.3 and page allocation failures..
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4807377b0601251459p76e4a6a1x1295ee3fd0cf95a5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1138048153.136509.119540@f14g2000cwb.googlegroups.com>
	 <32e47b670601231255l16fa0fa5i20823aab0c213971@mail.gmail.com>
	 <4807377b0601251459p76e4a6a1x1295ee3fd0cf95a5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the information. It does work now. However, I am having
similar problems with e100 driver on a dell 650 box. I am using the
e100 driver which comes with the 2.6.14.3 kernel and it throws similar
page allocation failures. Any help in this regard is appreciated.

Thanks

On 1/25/06, Jesse Brandeburg <jesse.brandeburg@gmail.com> wrote:
> On 1/23/06, Sai Bathina <sai.bathina@gmail.com> wrote:
> > Hi,
> >      I am seeing page allocation errors and I have a snapshot of the
> > /var/log/messages.
> >
> > My Hardware configs are
> > Dell 750, using e1000 driver(e1000-6.2.15)
>
> there is a leak in the 6.2.15 driver (this leak was not in the code
> submitted to the kernel)
>
> you can either use 6.3.9 or you can fix this by applying this attached
> patch (or something similar)
>
> Jesse
>
>
>
