Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbTAFS3V>; Mon, 6 Jan 2003 13:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbTAFS3S>; Mon, 6 Jan 2003 13:29:18 -0500
Received: from quattro.sventech.com ([205.252.248.110]:387 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S264883AbTAFS3L>; Mon, 6 Jan 2003 13:29:11 -0500
Date: Mon, 6 Jan 2003 13:37:49 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: "=?iso-8859-1?Q?=D8ystein_Svendsen?=" <svendsen@pvv.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with uhci and usb-uhci
Message-ID: <20030106133749.D18351@sventech.com>
References: <E18UxuX-0001yJ-00@localhost> <20030104184649.B14645@sventech.com> <3E17781D.30702@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E17781D.30702@pvv.org>; from svendsen@pvv.org on Sun, Jan 05, 2003 at 01:11:09AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2003, Øystein Svendsen <svendsen@pvv.org> wrote:
> Johannes Erdfelt wrote:
> 
> >Have you tried this with OHCI?
>
> I am not able to load the OHCI driver on my system, so the answer is no. 
>  I guess my hardware is not compatible.

I assume you have UHCI hardware then. You would need OHCI hardware to
use the OHCI driver :)

> >The error message for uhci.o atleast is returning back a babble error
> >which will then stall the pipe.
> >
> >A babble error is usually a driver or device issue.
>
> I am not very familiar on how the USB stuff works, but I'll try to take 
> a look on the usb-midi.c after I get some sleep.  I was assuming there 
> was trouble with the UHCI stuff because the USB bus seems to remain 
> stalled even after i unplug the MIDI adapter from the USB bus.

The bus doesn't STALL, but there may have been a problem with the host
controller.

For instance, some VIA controllers will lock up if it receives a BABBLE
condition.

JE

