Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbTIVFba (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 01:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbTIVFba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 01:31:30 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:40373 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262743AbTIVFb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 01:31:29 -0400
Date: Mon, 22 Sep 2003 07:31:03 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <petero2@telia.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Broken synaptics mouse..
Message-ID: <20030922053103.GA27045@ucw.cz>
References: <Pine.LNX.4.44.0309110744030.28410-100000@home.osdl.org> <m2fziqukhi.fsf@p4.localdomain> <20030921172758.GA21014@ucw.cz> <200309211816.36783.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309211816.36783.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 06:16:36PM -0500, Dmitry Torokhov wrote:

> > You can use EVIOCGRAB for the time being in the XFree86 synaptics
> > driver, this way you'll prevent its events coming into mousedev the
> > moment it's opened by XFree86, which is probably exactly what one wants.
> 
> Will that allow 2 processes to have access to the same event device 
> simultaneously? I am thinking about XFree and GPM. We just got away from
> that mess caused by psaux providing only exclusive access to step into
> the same problem again.

No, it won't. Yes, it's a problem. The only solution I can propose here
is when you want GPM and XFree support simultaneously you have to
configure both to use either /dev/input/mice, or both /dev/input/event,
and not mix the two together.

The EVIOCGRAB thing could be optional in X. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
