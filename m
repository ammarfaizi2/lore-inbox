Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265415AbTFMPmt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 11:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265417AbTFMPmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 11:42:49 -0400
Received: from angband.namesys.com ([212.16.7.85]:63872 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S265415AbTFMPms
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 11:42:48 -0400
Date: Fri, 13 Jun 2003 19:56:34 +0400
From: Oleg Drokin <green@namesys.com>
To: Christian Jaeger <christian.jaeger@ethlife.ethz.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lockups with loop'ed sparse files on reiserfs?
Message-ID: <20030613155634.GA18478@namesys.com>
References: <p04320407bb0f79fd523e@[192.168.3.11]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p04320407bb0f79fd523e@[192.168.3.11]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jun 13, 2003 at 03:38:44PM +0200, Christian Jaeger wrote:

> I've experienced 3 lockups in the last few days, all while using 
> sparse files. Could also be problems with UML, SKAS, raid5 over loop 
> device, or loop devices with vfat files, but it looks like the only 
> common thing is sparse files on reiserfs.
> 
> 1.) kernel 2.4.20 from debian unstable (= kernel.org kernel with 
> quite a few security and other patches), additionally patched with 
> kernel-patch-skas 3-1 from debian. Started user-mode-linux using a 
> sparse file with an ext2 filesystem on it, using tap0 networking, did 
> apt-get upgrade inside this uml (which started to download (and 
> already unpack?) quite a bit of stuff), halfway through the whole 
> (host) system froze. Still responded to pings, but telnet $host 80 
> would not show any activity from running apache. Went to the server 
> room, I could change virtual terminals with Alt-<number>, but could 
> not log in. Reset.

Were there anything interesting on the console where your kernel outputs
its messages (the host kernel?)?
Any chance to hit say sysrq-T/sysrq-P to find out where CPU spins?

> I'd mainly like to know if all of what I did is supported or not.

Yes it is supported. I am doing this kind of stuff (with uml and skas3)
on reiserfs everyday and everything works just fine with 2.4.19, 1.4.20 and 2.4.21.

Bye,
    Oleg
