Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbTDXHIW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 03:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbTDXHIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 03:08:21 -0400
Received: from angband.namesys.com ([212.16.7.85]:14216 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S261177AbTDXHIV
	(ORCPT <rfc822;linux-kernel@vger.redhat.com>);
	Thu, 24 Apr 2003 03:08:21 -0400
Date: Thu, 24 Apr 2003 11:20:27 +0400
From: Oleg Drokin <green@namesys.com>
To: "Tomasz Torcz, BG" <zdzichu@irc.pl>, LKML <linux-kernel@vger.redhat.com>
Subject: Re: [2.5.68] Failed to execute binary (UML); binary compatibility broken?
Message-ID: <20030424072027.GA2834@namesys.com>
References: <20030423184847.GA802@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423184847.GA802@irc.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Apr 23, 2003 at 08:48:47PM +0200, Tomasz Torcz, BG wrote:
> Initializing RT netlink socket
> Kernel panic: outer trampoline didn't exit with SIGKILL
> If I understand correctly, UML binary is ordinary executable.
> So if it is unable to start, evidently something very important 
> is broken.
> UML's kernel config attached.

This is known bug in UML. something related to sigchldhandler set to SIGIGN and
subsequent wait() call, as I remember.
The fix is exist and will be merged in next uml version.

Bye,
    Oleg
