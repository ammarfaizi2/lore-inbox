Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVBMXud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVBMXud (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 18:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVBMXud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 18:50:33 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:27736 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261318AbVBMXu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 18:50:29 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Stephen Evanchik <evanchsa@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Date: Sun, 13 Feb 2005 18:50:26 -0500
User-Agent: KMail/1.7.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <a71293c20502031443764fb4e5@mail.gmail.com> <200502032252.45309.dtor_core@ameritech.net> <a71293c2050213111345d072b0@mail.gmail.com>
In-Reply-To: <a71293c2050213111345d072b0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502131850.27329.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 February 2005 14:13, Stephen Evanchik wrote:
> On Thu, 3 Feb 2005 22:52:44 -0500, Dmitry Torokhov
> <dtor_core@ameritech.net> wrote:
> > OK, I have read the code once again, and saw that you have special
> > handling within PS/2 protocol based on model constant. Please set
> > psmouse type to PSMOUSE_TRACKPOINT instead of model and provide full
> > protocol handler, like ALPS, Synaptics and Logitech do. Trackpoint
> > is different and complex enough to warrant it.
> 
> I'm not sure that I think a protocol handler is necessary unless I am
> misunderstanding what you mean. The TrackPoint is nothing more than a
> PS/2 mouse with 2 or 3 buttons that responds to an additional set of
> commands. The extra handling has to do with middle-to-scroll which
> could be done in userspace.
> 

If middle-to-scroll is movd to userspace and there is no trackpoint-
specific handling added to the "normal" psmouse handler then we don't
need a new handler of course.

-- 
Dmitry
