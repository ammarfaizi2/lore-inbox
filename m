Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbVKIT3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbVKIT3F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 14:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbVKIT3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 14:29:04 -0500
Received: from tantale.fifi.org ([64.81.251.130]:1938 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S1030388AbVKIT3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 14:29:02 -0500
To: Dick <dm@chello.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SIGALRM ignored
References: <loom.20051107T183059-826@post.gmane.org>
	<20051107160332.0efdf310.pj@sgi.com>
	<loom.20051108T124813-159@post.gmane.org>
	<87hdamk56f.fsf@ceramic.fifi.org>
	<loom.20051109T101742-953@post.gmane.org>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 09 Nov 2005 11:28:58 -0800
In-Reply-To: <loom.20051109T101742-953@post.gmane.org>
Message-ID: <87r79pboxx.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dick <dm@chello.nl> writes:

> Philippe Troin <phil <at> fifi.org> writes:
> > > Does someone know a debugging technique to see whats happening?
> > Cat /proc/pid/status and look for the SigBlk line (blocked signals)
> > and the SigIgn (ignored signals).  SIGALRM is 14, look for bit 14,
> > that is 0000000000002000.  This bit should not be set.
> 
> And it is set (SigBlk: 0000000000012000) ... Thank you very much, I have to
> search in another direction.

Look at the display manager.  I know that wdm used to not clean up its
signals before starting a user session.

Phil.
