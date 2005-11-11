Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVKKBMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVKKBMV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 20:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbVKKBMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 20:12:21 -0500
Received: from tantale.fifi.org ([64.81.251.130]:20383 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S932332AbVKKBMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 20:12:20 -0500
To: Dick <dm@chello.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SIGALRM ignored
References: <loom.20051107T183059-826@post.gmane.org>
	<20051107160332.0efdf310.pj@sgi.com>
	<loom.20051108T124813-159@post.gmane.org>
	<87hdamk56f.fsf@ceramic.fifi.org>
	<loom.20051109T101742-953@post.gmane.org>
	<87r79pboxx.fsf@ceramic.fifi.org>
	<loom.20051110T210222-252@post.gmane.org>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 10 Nov 2005 17:12:17 -0800
In-Reply-To: <loom.20051110T210222-252@post.gmane.org>
Message-ID: <87k6fgq972.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dick <dm@chello.nl> writes:

> Philippe Troin <phil <at> fifi.org> writes:
> > Look at the display manager.  I know that wdm used to not clean up its
> > signals before starting a user session.
> 
> I've found the error, the signal was blocked in sshd and I was restarting sshd
> from a ssh session, I also disabled some pam modules (which I suspect the block
> came from). Restarting sshd from a console did the trick.

Daemons like ssh should clean-up their signal masks on start-up.
Maybe you should file a bug against ssh?

> I don't know how to thank you ;-)

Then don't :-)

Phil.
