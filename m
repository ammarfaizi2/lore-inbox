Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVCOPjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVCOPjW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 10:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVCOPjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 10:39:22 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:23624 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261325AbVCOPjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 10:39:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DzQtBAjLK/wdV73uCPfDnOT31t8QPjycnQsDXK2p430Qfh/ZXhUxCeZqkf5yBrmY4Qw6Ni6osh2VUG3mqetdhCZXKtynZGOxSOPRd1M2UECjh4YOU3siGsVheYlN3aDsa3440U9KtEquRUXci9OZr3AijuLivlkLcJWfBGwI8go=
Message-ID: <9e4733910503150739708a7414@mail.gmail.com>
Date: Tue, 15 Mar 2005 10:39:15 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: current linus bk, error mounting root
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050310162918.GD2578@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050309210926.GZ28855@suse.de> <20050310075049.GA30243@suse.de>
	 <9e4733910503100658ff440e3@mail.gmail.com>
	 <20050310153151.GY2578@suse.de>
	 <9e473391050310074556aad6b0@mail.gmail.com>
	 <20050310154830.GB2578@suse.de>
	 <9e47339105031007595b1e0cc3@mail.gmail.com>
	 <20050310160155.GC2578@suse.de>
	 <9e4733910503100818df5fb2@mail.gmail.com>
	 <20050310162918.GD2578@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this problem still being tracked?

I have figured out a work around of adding a 1 second pause in nash
after the ata_piix driver is loaded. Something has changed in the
driver initialization timing such that later stages of boot try to
access the driver before the driver has created the device without the
pause.

I am using Fedora Core 3 un modified except for the addition of the 1
second pause.

On Thu, 10 Mar 2005 17:29:19 +0100, Jens Axboe <axboe@suse.de> wrote:
> On Thu, Mar 10 2005, Jon Smirl wrote:
> > On Thu, 10 Mar 2005 17:01:55 +0100, Jens Axboe <axboe@suse.de> wrote:
> > > what are the major/minor numbers of /dev/root?
> >
> >
> > If I boot on a working system it is 8,5
> 
> I see no /dev/sda detected in your system from the dmesg. Ahh this is
> where it panics on loading ata_piix I suppose, can't you capture that
> panic with the serial console as well?
> 
> --
> Jens Axboe
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com
