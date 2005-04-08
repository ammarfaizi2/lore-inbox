Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbVDHMVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbVDHMVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 08:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbVDHMVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 08:21:39 -0400
Received: from mail.enyo.de ([212.9.189.167]:22193 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S262791AbVDHMVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 08:21:37 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<20050408041341.GA8720@taniwha.stupidest.org>
	<Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
	<20050408071428.GB3957@opteron.random>
	<20050408120244.GB10129@merlin.emma.line.org>
Date: Fri, 08 Apr 2005 14:21:34 +0200
In-Reply-To: <20050408120244.GB10129@merlin.emma.line.org> (Matthias Andree's
	message of "Fri, 8 Apr 2005 14:02:44 +0200")
Message-ID: <87fyy1bgs1.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthias Andree:

>> 	commiter_name		VARCHAR(32)	NOT NULL CHECK(commiter_name != ''),
>> 	commiter_email		VARCHAR(32)	NOT NULL CHECK(commiter_email != ''),
>
> The length is too optimistic and insufficient to import the current BK
> stuff.  I'd vote for 64 or at least 48 for each, although 48 is going to
> be a tight fit.  It costs a bit but considering the expected payload
> size it's irrelevant.

You should also check your database documentation if VARCHAR(n) is
actually implemented implemented in the same way as TEXT (or what the
unbounded string type is called), plus an additional length check.  It
doesn't make much sense to use VARCHAR if there isn't a performance
(or disk space) benefit, IMHO, especially for such data.
