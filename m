Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVE3W2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVE3W2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 18:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVE3W23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 18:28:29 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:44933 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261787AbVE3W1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 18:27:51 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Date: Mon, 30 May 2005 17:27:42 -0500
User-Agent: KMail/1.8
Cc: mrmacman_g4@mac.com, linux-kernel@vger.kernel.org, 7eggert@gmx.de
References: <4847F-8q-23@gated-at.bofh.it> <d120d500050527072146c2e5ee@mail.gmail.com> <429AD7ED.nail4ZG1B42TI@burner>
In-Reply-To: <429AD7ED.nail4ZG1B42TI@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505301727.43926.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 May 2005 04:07, Joerg Schilling wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > > Cdrecord includes the needed features to do what you like, but do not
> > > asume that you will be able to force me to make nonportable and Linux
> > > specific interfaces a gauge for the design of a portable program.
> > > If you read the cdrecord man page, you know that you could
> > > happily call cdrecord dev=green_burner.....
> > > 
> >
> > No, that static mapping is not good. I have an external enclosure that
> > does firewire and USB. I want to be able to use "sony-dvd" to access
> > it no matter whether it is onnected to USB bus or Firewire and whether
> > there are other devices (disks) on USB or firewire. It is possible to
> > do with udev creating a link to /dev/sony-dvd.
> 
> I am not sure what you like to do.....
> 
> But what you claim is simply impossible.
> 
> As you started to introduce the allegory with the colors, let me make 
> an assumption based on your claim:
> 
> -	Buy two identical drives and varnish one in red and the other 
> 	in green.
> 
> -	Connect both drives to your computer to let the OS "learn" the
> 	drives.
> 
> -	Do any setup you like
> 
> -	Now disconnect the drives and after that, connect the green one
> 	the way the red one has been connected before. 
> 
> -	Connect the red one too.
> 
> -	Insert a medium into the green drive
> 
> -	Let your software try whether it is able to connect you
> 	to the green one.
> 
> If this always works as expected, then you are a magician!
>

It will not work if drives are absolutely identical, however if there is
something even slightly different about them (serial number, model,
firmware version - anything) you can set up udev to produce "stable" name.

FWIW, my example was about a single drive that can "change" it's X,Y,Z
depending on how and when it was connected.

> So let me sum up: Never rely on things that cannot be made 100%
> unique in case you like to run security relevent software like cdrecord.

Are you talking about <bus>,<target>,<lun> numbering by any chance ;) ?
Because for the most types of devices out there they don't make any sense
and just provided for compatibility with legacy software.

Also, from a bit different perspective - do you also want users to mount
the CD they burnt using not device (/dev/xxx) but <bus>,<target>,<lun>?
If not why writing application should use different addressing? 

-- 
Dmitry
