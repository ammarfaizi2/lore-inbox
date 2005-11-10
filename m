Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVKJUHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVKJUHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVKJUHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:07:55 -0500
Received: from main.gmane.org ([80.91.229.2]:37324 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750787AbVKJUHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:07:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Dick <dm@chello.nl>
Subject: Re: SIGALRM ignored
Date: Thu, 10 Nov 2005 20:04:56 +0000 (UTC)
Message-ID: <loom.20051110T210222-252@post.gmane.org>
References: <loom.20051107T183059-826@post.gmane.org> <20051107160332.0efdf310.pj@sgi.com> <loom.20051108T124813-159@post.gmane.org> <87hdamk56f.fsf@ceramic.fifi.org> <loom.20051109T101742-953@post.gmane.org> <87r79pboxx.fsf@ceramic.fifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 62.163.56.10 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051012 Firefox/1.0.7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Troin <phil <at> fifi.org> writes:
> Look at the display manager.  I know that wdm used to not clean up its
> signals before starting a user session.

I've found the error, the signal was blocked in sshd and I was restarting sshd
from a ssh session, I also disabled some pam modules (which I suspect the block
came from). Restarting sshd from a console did the trick.

I don't know how to thank you ;-)

