Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVCILwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVCILwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 06:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbVCILwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 06:52:12 -0500
Received: from mail58-s.fg.online.no ([148.122.161.58]:58354 "EHLO
	mail58-s.fg.online.no") by vger.kernel.org with ESMTP
	id S261181AbVCILwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 06:52:06 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Logitech MX1000 Horizontal Scrolling
References: <873bxfoq7g.fsf@quasar.esben-stien.name>
	<87zmylaenr.fsf@quasar.esben-stien.name>
	<20050204195410.GA5279@ucw.cz>
	<873bvyfsvs.fsf@quasar.esben-stien.name>
	<87zmxil0g8.fsf@quasar.esben-stien.name>
	<1110056942.16541.4.camel@localhost>
	<87sm37vfre.fsf@quasar.esben-stien.name>
	<87wtsjtii6.fsf@quasar.esben-stien.name>
	<20050308205210.GA3986@ucw.cz>
From: Esben Stien <b0ef@esben-stien.name>
X-Home-Page: http://www.esben-stien.name
Date: Wed, 09 Mar 2005 12:33:32 +0100
In-Reply-To: <20050308205210.GA3986@ucw.cz> (Vojtech Pavlik's message of
 "Tue, 8 Mar 2005 21:52:10 +0100")
Message-ID: <873bv5m4tv.fsf@quasar.esben-stien.name>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> I don't think I have a patch for the MX1000 among them. I do have the
> MX1000, though, and I'm still thinking about what to do with it.

;)

> The problem is that the mouse really does reports all the double-button
> stuff and autorepeat, and horizontal wheel together with button press on
> wheel tilt.

This is a terrible hardware flaw if it can't be controlled.

Isnt't there a unique sequence we can determine when the horizontal
wheel is tilted?. When I turn off cruise control, all my buttons work
flawlessly, but not getting the autorepeat data. This autorepeat data
occurs between button press and button release and could be easily
forged.

> It has all that in the report descriptor, and the HID driver correctly
> interprets it and passes it on.

We should manipulate this data when it arrives in the kernel, in my
opinion. It's a faulty device and we should present it to userspace as
working.

> It's annoying, though.

Yeah, very, considering the capabilities of this device. 

> I could kill the extra buttons (via a HID quirk), which would leave us
> with autoscroll up/down/left/right, but the wheel wouldn't be
> distinguishable from the autoscroll anymore.

Not an option

> I can't kill the autoscroll alone and leave the buttons, because again
> the driver can't easily tell if it's the wheel or not.

I've killed the autoscroll by turning cruise control off; buttons work
then without auto repeat. I'm not sure what you mean here.

> In the end I think the best option is to leave the filtering to
> userspace, which will mean more configuration necessary in the X event
> mouse driver.

I hope this is not the final solution. I should be possible to disable
the data stream intervention if userspace wants to handle this, though.

-- 
Esben Stien is b0ef@esben-stien.name
http://www.esben-stien.name
irc://irc.esben-stien.name/%23contact
[sip|iax]:esben-stien.name
