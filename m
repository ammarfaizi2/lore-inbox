Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVDDSDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVDDSDa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 14:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVDDSDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 14:03:30 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:35300 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261313AbVDDSDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 14:03:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=nI2C5IygWZJnbTuyyWs6zNeTUYxJvUF0k8QUDZlB6fAmVEoTMaicmQMvzcUQGEuxPdyEOAdAy9EenUj4JE0DRs0/vqYK8mhpExditFHHBDoLp727d1/jyYNrKPOxhpFPPKBTA6Qbr4ird22ZJ5WYRrVNrRMS+0DDVfrT9VojaWs=
Message-ID: <d120d500050404110374fe9deb@mail.gmail.com>
Date: Mon, 4 Apr 2005 13:03:17 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Jaco Kroon <jaco@kroon.co.za>
Subject: Re: i8042 controller on Toshiba Satellite P10 notebook - patch
Cc: linux-kernel@vger.kernel.org, Sebastian Piechocki <sebekpi@poczta.onet.pl>
In-Reply-To: <42517442.20602@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <425166F9.1040800@kroon.co.za>
	 <d120d5000504040954354fb3fa@mail.gmail.com>
	 <42517442.20602@kroon.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 4, 2005 12:07 PM, Jaco Kroon <jaco@kroon.co.za> wrote:
> Dmitry Torokhov wrote:
> > Hi,
> >
> > On Apr 4, 2005 11:10 AM, Jaco Kroon <jaco@kroon.co.za> wrote:
> >
> >>Hello all
> >>
> >>A while back there was quite a discussion on this issue and then
> >>specifically "i8042 timing issues".  I refer you to
> >>http://lkml.org/lkml/2005/1/27/11 for more detail.
> >
> > ...
> >
> > I was under impression that "usb-handoff" kernel parameter fixed the
> > problem and therefore the patch is not needed. Am I wrong?
> >
> 
> Yes, to a certain extent.  usb-handoff causes the whole notebook to lock
> up at the next reboot (as in it doesn't even come up with the BIOS
> splash screen).  The only way to recover from that is to disconnect all
> power from the notebook, leave it for a couple of seconds, reconnect and
> only then can you go on.  It does however help with the whole
> touchpad/keyboard problem (can't remember whether it fixes the keyboard
> requires usb-1.1 or the AUX problem).
> 

I see... Have you tried compiling i8042, atkbd and psmouse as modules
and adjusting the init scripts so they are all loaded after USB
drivers are loaded - does it also cause lock up on reboot?  I wonder
if it is usb-handoff probem or it is a bigger problem with USB on your
Toshiba.

-- 
Dmitry
