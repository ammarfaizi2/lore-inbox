Return-Path: <linux-kernel-owner+w=401wt.eu-S964868AbWLMBJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWLMBJp (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 20:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWLMBJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 20:09:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:31218 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964868AbWLMBJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 20:09:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QF+Pni/DdqU5UYA69gRjkzBVPAJr2FlmvLqYpeRkdyj3/FxkewKpdhHnBVZOKZuH3nu9ucgf/Ss4nXpVKxHSo7G94t7PdpBrMydFF1VQ2eVDQ+GCKYKrQsV5kutNvtHwkKGotLMirRvc3LuKEd8JTnvMBEmyRGpLOMqYf0kyCW0=
Message-ID: <58cb370e0612121709x41270fb2p20280cc1edc9c533@mail.gmail.com>
Date: Wed, 13 Dec 2006 02:09:42 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.19-rc1] Toshiba TC86C001 IDE driver
Cc: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>, akpm@osdl.org,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061212234145.557cb035@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612130148.34539.sshtylyov@ru.mvista.com>
	 <20061212234145.557cb035@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/06, Alan <alan@lxorguk.ukuu.org.uk> wrote:

> > +static int tc86c001_busproc(ide_drive_t *drive, int state)
> > +{
>
> Waste of space having a busproc routine. The maintainer removed all the
> usable hotplug support from old IDE so this might as well be dropped.

I took over IDE when hotplug was already broken (late 2.5), moreover IDE
hotplug support has been always a quick hack according to its original author...
I remember your great efforts to fix it but unfortunately they
depended on executing
ioctls on non-existing devices which made them depend on layering
violation in 2.6,
also IDE device model fixes has some conflicts with them.  I take the
blame for not
applying them (for the reasons given above) and for taking much too
long in reviewing/testing them (due to lack of time not bad intention)
but accusing me of
intentional feature removal is going a bit too far...  You can hate me
all you want
for the way I did my entirely volunteer and unpaid job (but hey there
were and still is shortage of ATA hackers and there weren't anybody to
step up and takeover IDE)
but I actually have always taken responsibility/blame for all my
patches and patches
I accepted so if you really think I intentionally removed some usable
hotplug support
please point me to specific patch and describe the regression after
applying this
specific patch and I will do my best to have this regression fixed...

Bart
