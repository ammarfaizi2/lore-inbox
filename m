Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271152AbUJVAdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271152AbUJVAdA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 20:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271148AbUJVAcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 20:32:41 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:50934 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S271152AbUJVAbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 20:31:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=L9va9pvTAl0IcrhvYrTIPhcalj1jVjAWMsv9LSt545QC/a5fMLBYp59/aqDlWo03iQ7jaDa8mecAjLWNXNieurpwYogMauTTIRw+cA/ha0T2NwkFn7/BgqqgY/LoTNH+G0/UeAm6YvB+AKVWMDTzOe9+GCFjYo8Pm7cJfDmbg4w=
Message-ID: <58cb370e04102117316b5c250@mail.gmail.com>
Date: Fri, 22 Oct 2004 02:31:41 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH 2.4.28-pre4-bk6] delkin_cb: new driver for Cardbus IDE CF adaptor
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41785258.6060709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41780393.3000606@rtr.ca>
	 <58cb370e041021121317083a3a@mail.gmail.com>
	 <1098394354.17096.174.camel@localhost.localdomain>
	 <41783CDF.80007@rtr.ca> <58cb370e04102115572e992d75@mail.gmail.com>
	 <41784F51.5000308@rtr.ca> <58cb370e04102117153a92725d@mail.gmail.com>
	 <41785258.6060709@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004 20:20:40 -0400, Mark Lord <lkml@rtr.ca> wrote:
> >>+               drive->id->csfo = 0; /* workaround for idedisk_open bug */
> 
> Not there in the 2.6.xx version.
> 
> And in 2.4.xx.. why is idedisk_open() examining vendor-specific
> fields of the IDENTIFY data, anyway?  Very very unsafe.
> I put the above one-liner workaround (drive->id->csfo) into delkin_cb
> to bypass the problems it creates for now, until idedisk_open gets fixed.

id->csfo is still checked in 2.6.x but in idedisk_setup()

> Normally I'd just send a patch to fix idedisk_open(), but since I don't
> even understand what it is trying to do, it would be safer for whoever
> put that code there to have a second look.  Especially since 2.4.xx
> is supposed to be stable now -- if it ain't broke, don't break it.  :)

I guess that Alan knows more about id->csfo.
