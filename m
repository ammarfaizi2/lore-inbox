Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWAJQGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWAJQGE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 11:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWAJQGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 11:06:04 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:35688 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751139AbWAJQGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 11:06:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=BdqAtUp29kW9od6q4OHouCYnu23iZB1QEXmxzOkxw2OgbMfO6zaj1TzSQqBcZ9/5YyaN/UbrG94eaR56bXWDt8/pgrIkYROvokAmE/rbe5MrvJYnT7cVeNC/HKGpS9eBk7/wlIamD7aIQGtXD1+zvj4JJMoWRHAWlbo7uQVCClg=
Date: Tue, 10 Jan 2006 19:23:06 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-$SHA1: VT <-> X sometimes odd
Message-ID: <20060110162305.GA7886@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Approximate sequence of event:

1. script which builds allmodconfig on 11 targets is left on otherwise
   idle machine. Logged in on VT1. Logged of X.
2. After 5 hours I return, ensure script behaves OK, switch to X and see
   black screen.
3. Now, trying to switch between VTs and X gives nothing but black
   screen.
4. Alt+SysRq+K. After several seconds black screen switches to black
   screen with text cursor in the upper-left corner.
5. Futher attempts to switch and SysRq+Ki'ing gave nothing.
6. In a minute or so X login prompt reappeared. Mouse os OK. Keyboard is
   not. In particular, typing username doesn't work.
7. By some miracle, typing became OK (probably after I hit Ctrl, not
   sure). I login to X successfully and fire up mutt to mail bugreport.
8. Devil turned me to switch to VT again...
9. goto #5.
10. Cold reboot.

The overall feeling is that X left without human interaction starts to
reacts slooowly (probably after blanking kicks in?).

This is semi-reproducable, as in, I can't reproduce it at will but the
very same thing occured yesterday.

Now version numbers. All the above happened with
2.6.15-977127174a7dff52d17faeeb4c4949a54221881f

Yesterday it was 2.6.15-5367f2d67c7d0bf1faae90e6e7b4e2ac3c9b5e0f or
2.6.15-0aec63e67c69545ca757a73a66f5dcf05fa484bf, I don't remember. These
are just top entries in grub.conf.

