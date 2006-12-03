Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757674AbWLCMmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757674AbWLCMmo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 07:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757961AbWLCMmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 07:42:44 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:26072 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1757674AbWLCMmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 07:42:44 -0500
In-Reply-To: <20061203120130.GA32458@coresystems.de>
References: <5986589C150B2F49A46483AC44C7BCA490727C@ssvlexmb2.amd.com> <m1irgufl9q.fsf@ebiederm.dsl.xmission.com> <2ea3fae10612021247v33cfaa4evbc8ad1d5eaf196ba@mail.gmail.com> <m1ejrhfb9o.fsf@ebiederm.dsl.xmission.com> <20061203120130.GA32458@coresystems.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <77E505A2-6E0B-422F-92AB-97395730A522@kernel.crashing.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Peter Stuge <stuge-linuxbios@cdy.org>, linux-kernel@vger.kernel.org,
       linuxbios@linuxbios.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug device
Date: Sun, 3 Dec 2006 13:42:07 +0100
To: Stefan Reinauer <stepan@coresystems.de>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> you could use io delay, one outb uses roughly 1us iirc.

On LPC, yes -- or 0.5us or something like that.  On ISA it's
a lot faster, on PCI too -- better do 20 or so outb's to be
safe.  Or use a *real* timer instead, you'll have to abstract
this for portability anyway...


Segher

