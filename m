Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVFPWOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVFPWOv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 18:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVFPWOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 18:14:51 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:47553 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261692AbVFPWOp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:14:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C/t2LkGQDMx9MrsoO3l34IZNRxrvY6EqobYex+N48dZaQ6VTIebscuj/M5TAsBsWk2fg6gcY4kM6Jd0oenYXcHF/PtfgIR7rUbN0ugQLNkzKDw/fFrYVWBb5z1YdIiGJwqTll0ThA7t2sPyK5ty00tPA57U5UcVyy1OGOEOEU/o=
Message-ID: <4ad99e0505061615143cc34192@mail.gmail.com>
Date: Fri, 17 Jun 2005 00:14:44 +0200
From: Lars Roland <lroland@gmail.com>
Reply-To: Lars Roland <lroland@gmail.com>
To: Christian Kujau <evil@g-house.de>
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42B1F5CB.9020308@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ad99e0505061605452e663a1e@mail.gmail.com>
	 <42B1F5CB.9020308@g-house.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/05, Christian Kujau <evil@g-house.de> wrote:
> Lars Roland schrieb:
> > So are there any differences in the tg3 driver between 2.6.8.1 and
> > 2.6.12-rc6 that would cause this kind of behaviour ?.
> 
> i'd say: "certainly", but best you find out by diff'ing the versions
> and/or eventually put 2.6.8.1's tg3 driver in a 2.6.12-rc6 tree, compile,
> hope it builds, then try again to connect.

It does not seams to be limited to braodcom cards. 3com and Intel e100
cards does the exact same stunt on kernels never than 2.6.8.1. Intel
e1000 and realtek 8139 cards do however work.

> 
> > I know that SMTP fixup is mostly a poorly implemented Sendmail
> 
> i don't know what a "smtp fixup" would be, but does the disconnect happen
> to other applications too?

SMTP fixup is a dirty hack where the firewall limits the amount of
SMTP commands that can be used in the session to only the core rfc 821
commands. Most people do however use it just to hide the actual
receiving mail server from the sender - my guess is that the Cisco PIX
changes the frames/packages and then the connection gets dropped. I
got the admin to turn it off temporally and then the tg3 works just
fine.


Regards.

Lars Roland
