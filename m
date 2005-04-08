Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262928AbVDHS6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262928AbVDHS6J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbVDHS6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:58:09 -0400
Received: from mail.enyo.de ([212.9.189.167]:16569 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S262923AbVDHS6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:58:06 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<20050408041341.GA8720@taniwha.stupidest.org>
	<Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
	<20050408071428.GB3957@opteron.random>
	<Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org>
	<4256AE0D.201@tiscali.de>
	<Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
	<4256BE7D.5040308@tiscali.de>
	<Pine.LNX.4.58.0504081047200.28951@ppc970.osdl.org>
	<9e473391050408112865ed5d17@mail.gmail.com>
Date: Fri, 08 Apr 2005 20:58:02 +0200
In-Reply-To: <9e473391050408112865ed5d17@mail.gmail.com> (Jon Smirl's message
	of "Fri, 8 Apr 2005 14:28:59 -0400")
Message-ID: <87u0mh5c5h.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jon Smirl:

> On Apr 8, 2005 2:14 PM, Linus Torvalds <torvalds@osdl.org> wrote:
>>    How do you replicate your database incrementally? I've given you enough
>>    clues to do it for "git" in probably five lines of perl.
>
> Efficient database replication is achieved by copying the transaction
> logs and then replaying them.

Works only if the databases are in sync.  Even if the transaction logs
are pretty high-level, you risk violating constraints specified by the
application.  General multi-master replication is an unsolved problem.
