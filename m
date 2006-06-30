Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWF3MHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWF3MHd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 08:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWF3MHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 08:07:32 -0400
Received: from wx-out-0102.google.com ([66.249.82.199]:10 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932197AbWF3MHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 08:07:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KVaNGY9H2BL4ej7xrlVgEuPLSWgIX7RGOamrNyJLGy99N4gbRzMWyBbtejZThhgiE+ak3NwG0Q95bg5WXKIL2qOMEkliQoRieLKUtjfVbwirdb00tQOrI6jcWcYQ6E9TAwdspFWoxN+wHCHzrpgXH3+uhKMgXC7tGcVjRMWA+DM=
Message-ID: <39f633820606300507h68333a66xb6750e7d6cd652b1@mail.gmail.com>
Date: Fri, 30 Jun 2006 14:07:31 +0200
From: "Robert Nagy" <robert.nagy@gmail.com>
To: "Jesse Barnes" <jbarnes@virtuousgeek.org>
Subject: Re: Intel RAID Controller SRCU42X in SGI Altix 350
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606291342.38580.jbarnes@virtuousgeek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <39f633820606290818g1978866ap@mail.gmail.com>
	 <200606291132.51866.jbarnes@virtuousgeek.org>
	 <39f633820606291212v40b0016cl@mail.gmail.com>
	 <200606291342.38580.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried that with two different cards. Now the error is different.
Even the firmware boots on the controller but then the machine resets.
Same thing happens if I load the EFI driver but that drops me to the debugger.
More info can be found at http://pastebin.ca/75652

megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
megaraid: 2.20.4.8 (Release Date: Mon Apr 11 12:27:22 EST 2006)
megaraid: probe new device 0x1000:0x0407:0x8086:0x0532: bus 2:slot 0:func 0
ACPI: PCI Interrupt 0002:02:00.0[A]: no GSI
megaraid mailbox: wait for FW to boot [ok]
Entered OS MCA handler. PSP=20000000fff21120 cpu=0 monarch=1
All OS MCA slaves have reached rendezvous

2006/6/29, Jesse Barnes <jbarnes@virtuousgeek.org>:
> On Thursday, June 29, 2006 12:12 pm, Robert Nagy wrote:
> > I've tried the diff but there is no difference.
> > I've also tried to use the EFI driver from Intel, but that did not
> > work either.
>
> I've just been informed that megaraid has command ring addressing
> limitations, so you may not be able to use this card in PCI-X mode at
> all, at least on your Altix.  You can force it into PCI mode by putting
> an old PCI device in the same bus though, I think, that might get things
> working (without my patch).
>
> Jesse
>
