Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262805AbVBCPZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbVBCPZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 10:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbVBCPTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 10:19:38 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:17640 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263679AbVBCPRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 10:17:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DlmxwGPU5D5Metnm1brSmR43ikVjFuxk8VrrjfEMlKlXGC+sMYQxWpaJviTe3IqfrJQ/YkhwzCftbAqPANLmlYPr3NiHv7PmoMXqbOURBPbLEYB/d2v0x03FURhr2ANdSWEVe+o+QXPthhrcARVDWAY5/R82wwarLZRrIwbQZY0=
Message-ID: <d120d50005020307175e88ddcc@mail.gmail.com>
Date: Thu, 3 Feb 2005 10:17:41 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Victor Hahn <victorhahn@web.de>
Subject: Re: Really annoying bug in the mouse driver
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42023DC4.4020100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41E91795.9060609@web.de>
	 <200502011819.12304.dtor_core@ameritech.net> <42006E79.7070503@web.de>
	 <200502020126.37621.dtor_core@ameritech.net> <4200A9F3.80908@web.de>
	 <d120d50005020207443ceb8704@mail.gmail.com> <42023DC4.4020100@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Feb 2005 16:05:40 +0100, Victor Hahn <victorhahn@web.de> wrote:
> Dmitry Torokhov wrote:
> 
> >Processor load we usually handle well, loaded disks are usually the
> >ones that cause >= 0.5 sec delays between bytes received by psmouse.
> >Please let me know if it still works with busy disks.
> >
> >
> Yes, it does work. I was copying several gigs from one partition to
> another and in the meantime copying some data to another computer via a
> 100Mbit link and I didn't encounter any problems.
> 

Great, thank you very much for testing it! I guess I should push it
upstream... I think that there is a small problem with the patch (it
may get upset on the boxes that don't have mouse connected and KBC
reports timeouts during probing), but it is fixable and shoudl not
affect your case.

> Since I use kernel 2.6.11-rc2 with your patch, I sometimes get a lot of
> very strange messages in /var/log/messages and on the terminal I'm
> currently working with. I mean something like this:
> 
...

Looks line network is upset - I'd ask networking guys - netdev@oss.sgi.com

-- 
Dmitry
