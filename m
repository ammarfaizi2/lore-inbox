Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289211AbSBJC6q>; Sat, 9 Feb 2002 21:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289213AbSBJC6d>; Sat, 9 Feb 2002 21:58:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19983 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289211AbSBJC60>; Sat, 9 Feb 2002 21:58:26 -0500
Subject: Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4)
To: lm@bitmover.com (Larry McVoy)
Date: Sun, 10 Feb 2002 02:46:37 +0000 (GMT)
Cc: stelian.pop@fr.alcove.com (Stelian Pop),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        adilger@turbolabs.com (Andreas Dilger)
In-Reply-To: <20020209122649.E13735@work.bitmover.com> from "Larry McVoy" at Feb 09, 2002 12:26:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Zk0j-0000Eh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a password.  I know about ssh-agent but that doesn't help for this, 
> I know that in certain cases ssh lets me in without anything.  I thought
> there was some routine where you ssh-ed one way and then the other way
> and it left enough state that it trusted you, does any ssh genuis out 
> there know what I'm talking about?  If I have this, I can set up the
> cron job, I'm sure this is obvious and I'm just overlooking something
> but I can't find it.

For the paranoid 

You ssh from the source to an untrusted chrooted nopriv uid on the target
using a ssh pass phrase and ipchains static ip rules to allow only some
IP's access

A cron or other triggered job on the receiving machine checks the GPG
signatures of the uploaded data and moves/processes it if it matches or
if the key matches blocks off that machine and ID and mails the admin.

Alan
