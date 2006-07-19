Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWGSKUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWGSKUe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 06:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWGSKUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 06:20:34 -0400
Received: from posthamster.phnxsoft.com ([195.227.45.4]:52486 "EHLO
	posthamster.phnxsoft.com") by vger.kernel.org with ESMTP
	id S964786AbWGSKUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 06:20:34 -0400
From: Tilman Schmidt <tilman@imap.cc>
To: linux-kernel@vger.kernel.org
Subject: Re: Reiser4 Inclusion
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Matthias Andree <matthias.andree@gmx.de>,
       Grzegorz Kulewski <kangur@polcom.net>,
       Diego Calleja <diegocg@gmail.com>, arjan@infradead.org,
       caleb@calebgray.com
Date: Wed, 19 Jul 2006 11:27:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID: <fake-message-id-1@fake-server.fake-domain>
References: <44BAFDB7.9050203@calebgray.com> <1153128374.3062.10.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net> <20060717160618.013ea282.diegocg@gmail.com> <Pine.LNX.4.63.0607171611080.10427@alpha.polcom.net> <20060717155151.GD8276@merlin.emma.line.org> <Pine.LNX.4.61.0607180951480.16615@yvahk01.tjqt.qr> <20060718204718.GD18909@merlin.emma.line.org>
X-Spam-Score: 3.608 (***) BAYES_80
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2006 22:50:06 +0200, Matthias Andree wrote:

> Jan Engelhardt schrieb am 2006-07-18:
>
>> If namesys provided reiser4 patches for every vanilla out 
>> there [...], that would 
>> be great, but I cannot force them to do so; people may have better things 
>> to do than packaging up r4 whenever there is a linux tarball release.
>
> And probably kernel hackers have better things to do than keeping that
> code building if they don't mean to support it. This touches the "stable
> APIs" can of worms again, so let's stop here before it springs open.

But that's exactly the point. No good sweeping it under the carpet.
The entire concept of not having a stable API hinges on being able
to get code into the main kernel tree, and "kernel hackers keeping
that code building" is explicitly part of the promise. As the
document with the nicely nettling name "stable_api_nonsense.txt"
says:

  You think you want a stable kernel interface, but you really do not, and
  you don't even know it.  What you want is a stable running driver, and
  you get that only if your driver is in the main kernel tree.

Conversely, the fact that for very good reasons there isn't, and
won't be, a stable API is a major source of pressure to get things
into the kernel. It is even touted as such. Each time some
maintainer of an out-of-tree piece of code asks a question about an
incompatible change he or she is told: "it wouldn't be a problem if
your code were in the main kernel tree".

But all the nice arguments turn moot if someone who takes them to
heart and duly submits his or her code for inclusion in the main
kernel tree is turned away at the door. Someone who *cannot* get his
or her driver into the main kernel tree (no matter for what reason)
will quite naturally conclude that stable_api_nonsense.txt is itself
nonsense and a stable API might not be such a bad idea after all.

You can't have it both ways. Either you want everything in the main
kernel tree or you don't. Of course there will always be a limbo of
code waiting for inclusion. But if it has to linger there for too
long (again: no matter for what reason) then it invalidates the
whole concept of not having a stable API. And that would be a pity.

HTH
Tilman

