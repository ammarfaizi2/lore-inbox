Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUGFH2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUGFH2b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 03:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUGFH2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 03:28:31 -0400
Received: from mailgate1.siemens.ch ([194.204.64.131]:5318 "EHLO
	mailgate1.siemens.ch") by vger.kernel.org with ESMTP
	id S263093AbUGFH23 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 03:28:29 -0400
From: Marc Waeckerlin <Marc.Waeckerlin@siemens.com>
Organization: Siemens Schweiz AG
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Continue: psmouse.c - synaptics touchpad driver sync problem
Date: Tue, 6 Jul 2004 09:27:43 +0200
User-Agent: KMail/1.6
Cc: laflipas@telefonica.net, linux-kernel@vger.kernel.org, t.hirsch@web.de,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20040630132305.98864.qmail@web81306.mail.yahoo.com> <200407011434.59340.Marc.Waeckerlin@siemens.com> <200407010804.00438.dtor_core@ameritech.net>
In-Reply-To: <200407010804.00438.dtor_core@ameritech.net>
X-Face: 9PH_I\aV;CM))3#)Xntdr:6-OUC=?fH3fC:yieXSa%S_}iv1M{;Mbyt%g$Q0+&K=uD9w$8bsceC[_/u\VYz6sBz[ztAZkg9R\txq_7]J_WO7(cnD?s#c>i60S
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407060927.43588.Marc.Waeckerlin@siemens.com>
X-OriginalArrivalTime: 06 Jul 2004 07:27:47.0628 (UTC) FILETIME=[BC8BEEC0:01C4632A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 1. Juli 2004 15.03 schrieb Dmitry Torokhov unter "Re: Continue: 
psmouse.c - synaptics touchpad driver sync problem":
> Just out of curiosity, what happens when you pass psmouse.proto=bare to the
> kernel as a boot option (or put "options psmouse proto=bare" in your
> /etc/modprobe.conf file if psmouse is compiled as a module)?    

I tested again with psmouse.proto=bare and psmouse.resetafter=3 and *internal* 
touchpad/keyboard *only*. Last time, I told you, there's no ovious effect and 
it still does not work. That might be correct for the external equipment, but 
with internal mouse, the effects are much more subtile:


psmouse.proto=bare

 -> Now the internal mouse behaves as bad as the external one! It jumps around 
like crazy and clicks everywhere. That means, problems No. 3 and No.4 now 
also apply to the internal mouse!

 -> But problem No. 5 is resolved! Clicking on the touchpad does a button-1 
click.


psmouse.resetafter=3

 -> Problems No. 1 and No. 2 now become much worse! That means when moving the 
mouse cursor, cursor often stops/blocks. Then I have to keep the fingers off 
the touchpad for several seconds, before I can continue to move the mouse. 
Either regardless of the system load, or the lowest system load can start 
this effect, that's not so clear.

 -> Also the cursor now jumps much more than ever before.

So, that might be a way for a workaround: Can "reset" be disabled, e.g. 
secifying "psmouse.resetafter=0"?


Regards
Marc
