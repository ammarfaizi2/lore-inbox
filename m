Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264594AbTLWAKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 19:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264598AbTLWAKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 19:10:35 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:28090 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264594AbTLWAKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 19:10:33 -0500
Subject: Re: [PATCH 2/2][RFC] Add dm-crypt target
From: Christophe Saout <christophe@saout.de>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Joe Thornber <thornber@sistina.com>
In-Reply-To: <20031222235040.GU6438@matchmail.com>
References: <1072129379.5570.73.camel@leto.cs.pocnet.net>
	 <20031222215236.GB13103@leto.cs.pocnet.net> <3FE7794D.7000908@pobox.com>
	 <20031222232433.GT6438@matchmail.com> <3FE77E49.4010303@pobox.com>
	 <20031222235040.GU6438@matchmail.com>
Content-Type: text/plain
Message-Id: <1072138227.13664.19.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Dec 2003 01:10:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, den 23.12.2003 schrieb Mike Fedyk um 00:50:

> > dm-crypt should not be constrained by cryptoloop, and vice versa.
> 
> It seems dm-crypt was meant to overcome the problems with loop against block
> devices.  If it uses another format, it would loose that ability to be a
> replacement, and unless there are shortcomings in the format, why should
> there be a change?

The target option line is quite flexible. It could be used to list the
required crypto features. If only an encryption cipher is selected, it
would be backward compatible with the cryptoloop on-disk format (like it
is now). But when additional options are given IV hashing could be
turned on, another option could turn on block shuffling or something.

I'm currently having a private conversation with the cryptoloop
maintainer. The possibilities in cryptoloop are mainly restricted by the
losetup interface, he would love to have more possibilities. There are a
lot of things that could and should be implemented.

> Also, while cryptoloop on block devices may be bass ackwards to get
> encryption (use a driver meant to turn files into block devices on another
> block device since there is now crypto tied into it...), if there's another
> format, won't that data become inaccessable unless it's in a block device,
> or do you get the dm-crypt -> loop -> file in the case a dm-crypt image gets
> copied to a file?

dm-crypt -> loop -> file should work. Just like LVM on top of a file,
I've already done that before.

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

