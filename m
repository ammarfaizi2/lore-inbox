Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265945AbUAUMzM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 07:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265951AbUAUMzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 07:55:11 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:62868 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265945AbUAUMxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 07:53:51 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.1-mm4
Date: Wed, 21 Jan 2004 07:53:42 -0500
User-Agent: KMail/1.5.4
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <p73r7xwglgn.fsf@verdi.suse.de> <20040121132744.1094129f.ak@suse.de> <20040121123454.GB538@ucw.cz>
In-Reply-To: <20040121123454.GB538@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401210753.42841.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 January 2004 07:34 am, Vojtech Pavlik wrote:
> On Wed, Jan 21, 2004 at 01:27:44PM +0100, Andi Kleen wrote:
> > On Wed, 21 Jan 2004 09:40:09 +0100
> >
> > Vojtech Pavlik <vojtech@suse.cz> wrote:
> > > Inbetween the module changes and the input changes there was a
> > > situation, where you'd have to pass
> > >
> > > 	psmouse.psmouse_maxproto=imps2
> > >
> > > as a kernel argument. This should (I hope so, I have to check) be
> > > fixed now.
> >
> > No, 2.6.1 requires it.
> >
> > And worst is that you have to reboot to change mouse settings at all.
> > That just doesn't make any sense. Can you please add an runtime sysfs
> > interface for this?
>
> It's planned, though not easy to implement at all. I don't think I'll
> be able to get this into 2.6.2. For now you can enable EMBEDDED,
> compile psmouse as a module, and just rmmod/insmod it with new
> parameters.

No, it's just mousedev that is always built-in, psmouse can be compiled
as a module (and that's the reason the whole naming mess happened - I use
it as a module and haven't noticed the necessity of the prefixes when
converted to the module_param()).

-- 
Dmitry
