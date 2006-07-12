Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWGLDzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWGLDzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 23:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWGLDzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 23:55:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:14533 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932396AbWGLDzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 23:55:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J0TH2skiFZNfxD2rMuHz5t8Ph5nZz99Uw5KafRrAm+P8yqxxTsZNUmsTWPlfRGjfK+XeWKxZ2/5+RuSuInLVByu1tlc7T1Qpn+OxRg86JEdVPMT0h79iCq5kRgaDbFUz81OxQVBxVv6kLkaEw+Zta7WWbhqGx0srFvVBjf4pzs0=
Message-ID: <9e4733910607112055o6a399628o13c6ac0d7bdb08d4@mail.gmail.com>
Date: Tue, 11 Jul 2006 23:55:11 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty's use of file_list_lock and file_move
Cc: "Theodore Tso" <tytso@mit.edu>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910607111650m16630157ya8c27949ae639ffc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
	 <1152573312.27368.212.camel@localhost.localdomain>
	 <9e4733910607101604j16c54ef0r966f72f3501cfd2b@mail.gmail.com>
	 <9e4733910607101649m21579ae2p9372cced67283615@mail.gmail.com>
	 <20060711012904.GD30332@thunk.org>
	 <20060711194456.GA3677@flint.arm.linux.org.uk>
	 <9e4733910607111508x526ee642p5b587698306b22d3@mail.gmail.com>
	 <1152657465.18028.72.camel@localhost.localdomain>
	 <9e4733910607111650m16630157ya8c27949ae639ffc@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How exactly are /dev/tty0 and /dev/console supposed to work?

I thought that /dev/tty0 was the currently active tty.
And /dev/console is where the printk output is going.

/dev/tty0 appears to be snapshoting the currently active tty when it
is opened. It does not track changes to the foreground console.

It looks like TIOCCONS effects both /dev/tty0 and /dev/console. tty0
uses console_fops with redirected_tty_write().

Am I reading the code right, and are these the correct behaviors?

What is the equivalent to the setconsole command for Fedora?

-- 
Jon Smirl
jonsmirl@gmail.com
