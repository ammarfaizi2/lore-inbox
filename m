Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbUKEXkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbUKEXkE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbUKEXkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:40:04 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:27848 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261274AbUKEXiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:38:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=eB4AGXmigUMkJHF7D7snK1VBYf61GLfVeqf6wqWaafn3Ds5mHFHYfmVKh/kRgl6vQ1W+kcQjHz1UU0VwkSBWAphZTRTeWOgb0ZA5PxOH9M3DvRvryEfY8cjhK9HI6A6A6aRDKKpFi1AY11RMjwJy68S/dZ4fWQMt4XnSM0rabCE=
Message-ID: <66dc751804110515386d92892a@mail.gmail.com>
Date: Fri, 5 Nov 2004 18:38:00 -0500
From: chibiryuu <ephemient@gmail.com>
Reply-To: chibiryuu <ephemient@gmail.com>
To: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: support of older compilers [u]
Cc: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>,
       Linus Torvalds <torvalds@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       Andries Brouwer <aebr@win.tue.nl>, Adam Heath <doogie@debian.org>,
       Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.60.0411060003550.3255@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
	 <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com>
	 <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org>
	 <20041105014146.GA7397@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org>
	 <20041105195045.GA16766@taniwha.stupidest.org>
	 <Pine.LNX.4.58.0411051203470.2223@ppc970.osdl.org>
	 <Pine.LNX.4.60.0411052242090.3255@alpha.polcom.net>
	 <1099694246.4450.11.camel@nosferatu.lan>
	 <Pine.LNX.4.60.0411060003550.3255@alpha.polcom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And yes, I probably can force UDEV to stop creating /dev/sda[0-9]*
> devices, but this is not the right solution I think. These config files
> are managed by my distribution and are complicated. I do not want to have
> to merge them with updates every time new UDEV is released. Besides I want
> to disable kernel partition discovery just for this device. This will be
> ugly excaption.

You can just place a file in /etc/udev/rules.d; your distribution may
have files (50-udev.rules) in there already, but if you create a file
which is lexically before them (10-local.rules), rules in it will take
precedence -- well, be parsed first -- and your distribution should
not overwrite your file.
