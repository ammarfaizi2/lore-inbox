Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264975AbVBDON1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264975AbVBDON1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 09:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbVBDON1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 09:13:27 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:16942 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265610AbVBDOMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 09:12:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=pzU61dArP0Q3BZlKJAHaow3QjpCoYjgHW5WdGcn/gm+mg+RgPsqYrR42HfMlitclndWCn+A4Jozp97Ug+O7ql6kQYbHKU1VMi3DQvDmtdEc9/O58yBotZn1p5iVDoGhaw/ifqzLJGUvoxm4kGGXWOqSEI9HNcUVE1jiwNlVUG7U=
Message-ID: <d120d5000502040612715ac6c1@mail.gmail.com>
Date: Fri, 4 Feb 2005 09:12:49 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Cc: Stephen Evanchik <evanchsa@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050204134528.GA12001@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <a71293c20502031443764fb4e5@mail.gmail.com>
	 <200502031934.16642.dtor_core@ameritech.net>
	 <20050204063520.GD2329@ucw.cz>
	 <a71293c205020405174ffa8d9d@mail.gmail.com>
	 <20050204134528.GA12001@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005 14:45:28 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Fri, Feb 04, 2005 at 08:17:43AM -0500, Stephen Evanchik wrote:
> > On Fri, 4 Feb 2005 07:35:20 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > > Indeed. IIRC this patch killed wheel mouse detection in ubuntu.
> >
> > Earlier versions of the patch didn't disable the device while probing
> > so events could be interpreted as the magic ID of a TrackPoint. It now
> > resets and disables the PS/2 device before detection but not after a
> > detect failure.
> 
> Since we fixed libps2, this shouldn't happen anymore, as long as the
> BIOS doesn't inject an endless stream of data from an USB mouse.
> 

I don't think changes in libps2 affect this problem in any way -
psmouse does PSMOUSE_CMD_RESET_DIS before trying to do any protocol
probing so there should be no events from the mouse during detection
phase.

-- 
Dmitry
