Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280095AbRKIUlB>; Fri, 9 Nov 2001 15:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280096AbRKIUkw>; Fri, 9 Nov 2001 15:40:52 -0500
Received: from gizmo.catnap.com ([198.168.192.2]:18438 "HELO gizmo.catnap.com")
	by vger.kernel.org with SMTP id <S280095AbRKIUko>;
	Fri, 9 Nov 2001 15:40:44 -0500
Message-ID: <20011109204043.17315.qmail@gizmo.catnap.com>
Subject: Re: ramfs leak
To: linux-kernel@vger.kernel.org
Date: Fri, 9 Nov 2001 15:40:43 -0500 (EST)
Cc: padraig@antefacto.com (Padraig Brady)
In-Reply-To: <no.id> from "Padraig Brady" at Nov 08, 2001 11:39:28 AM
From: wcm@catnap.com (W Christopher Martin)
Organization: Catnap Consultants
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Padraig Brady writes:
> When I remove files from a ramfs the space is not reclaimed?
> What am I doing wrong? Details below.

Nothing.  We've noticed the same thing.  It's a bug and was
first reported back in July, but no one has provided a fix yet.
I've had a brief look at the source code, but nothing obvious
pops out at me.

As you mention, this problem is trivially reproducable by
creating and then deleting a file.  Doing that over and over
eventually leads to the ramfs becoming full.  Only a reboot
(or perhaps a umount/mount) makes it usable again.

Chris Martin
Catnap Consultants
