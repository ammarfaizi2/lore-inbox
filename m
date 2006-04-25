Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWDYPXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWDYPXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 11:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWDYPXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 11:23:04 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:19073 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932251AbWDYPXD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 11:23:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nf9+BIaOOOjLUbcJBw4sznjCuXqW/GjgdGyepTUxDRhQ5suKPNqTKkQk6rzH3aGHsAb3DkLORtK3h6dD3hsAiGl6yrtCFMKlqDTzLln4ESEhg0SCcU6X8ePwZbgv3hdw4hKqWrXd17LTi2i+2eYDR0VHy9xYPIvnLsQKGHi6L4c=
Message-ID: <d120d5000604250823p4f2ed2acv4287f7d70c71c7c0@mail.gmail.com>
Date: Tue, 25 Apr 2006 11:23:02 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: [PATCH 001/001] INPUT: new ioctl's to retrieve values of EV_REP and EV_SND event codes
Cc: bjd <bjdouma@xs4all.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20060425151628.GA11078@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060422204844.GA16968@skyscraper.unix9.prv>
	 <d120d5000604240731i5a3667f9g37e94de390485aac@mail.gmail.com>
	 <20060424145747.GA5906@suse.cz>
	 <d120d5000604240803q387343dt8e9801a8cf21a975@mail.gmail.com>
	 <d120d5000604250619r6170c18bh8d26fc041141c056@mail.gmail.com>
	 <20060425151628.GA11078@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Tue, Apr 25, 2006 at 09:19:42AM -0400, Dmitry Torokhov wrote:
> > On 4/24/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > On 4/24/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > > > On Mon, Apr 24, 2006 at 10:31:39AM -0400, Dmitry Torokhov wrote:
> > > > >
> > > > > Vojtech, could you remind me why EVIOC{G|S}REP were removed? Some
> > > > > people want to have ability to separate keyboards (via grabbing); they
> > > > > also might want to control repeat rate independently. Shoudl we
> > > > > reinstate these ioctls?
> > > >
> > > > I believe they were replaced by the ability to send EV_REP style events
> > > > to the device, setting the repeat rate.
> > > >
> > >
> > > Argh, why am I always forgetting about ability to write events into devices?
> >
> > Thinking about it some more - writing to the event device is an
> > elegant way to set repeat rate but how do you retrieve current repeat
> > rate for a given device?
>
> You can't. And that's likely a problem that needs fixing.
>

So do you agree that we need to ressurect EVIOCGREP (and EVIOCSREP
just to complement the interface)?

--
Dmitry
