Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVBMTNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVBMTNb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 14:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVBMTNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 14:13:31 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:43807 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261297AbVBMTNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 14:13:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=X+RQmpM4NL7zB18fjKCe47F1YXmHsLsNNqQzG5+TEmH4s5iTD5D7IaJTTsZotkcsAL0jhjY+9nV0gHmAVQYXDSgW1ni2Yf5sv0mQnhoj9esoyitT9YOkD9xI4Edr/oyap8GVuTXv3Ooic+b/Nm9rJ1fvomzS2joSeBrqR5eTqD4=
Message-ID: <a71293c2050213111345d072b0@mail.gmail.com>
Date: Sun, 13 Feb 2005 14:13:15 -0500
From: Stephen Evanchik <evanchsa@gmail.com>
Reply-To: Stephen Evanchik <evanchsa@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <200502032252.45309.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <a71293c20502031443764fb4e5@mail.gmail.com>
	 <200502031934.16642.dtor_core@ameritech.net>
	 <200502032252.45309.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005 22:52:44 -0500, Dmitry Torokhov
<dtor_core@ameritech.net> wrote:
> OK, I have read the code once again, and saw that you have special
> handling within PS/2 protocol based on model constant. Please set
> psmouse type to PSMOUSE_TRACKPOINT instead of model and provide full
> protocol handler, like ALPS, Synaptics and Logitech do. Trackpoint
> is different and complex enough to warrant it.

I'm not sure that I think a protocol handler is necessary unless I am
misunderstanding what you mean. The TrackPoint is nothing more than a
PS/2 mouse with 2 or 3 buttons that responds to an additional set of
commands. The extra handling has to do with middle-to-scroll which
could be done in userspace.

Aside from that the only time TracKPoint specific processing occurs is
when some property is being manipulated.

Do you still think a custom handler is necessary? 

Stephen
