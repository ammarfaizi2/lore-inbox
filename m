Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318742AbSH1HAG>; Wed, 28 Aug 2002 03:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318743AbSH1HAF>; Wed, 28 Aug 2002 03:00:05 -0400
Received: from hal.astr.lu.lv ([195.13.134.67]:19332 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S318742AbSH1HAF> convert rfc822-to-8bit;
	Wed, 28 Aug 2002 03:00:05 -0400
From: Andris Pavenis <pavenis@latnet.lv>
To: Doug Ledford <dledford@redhat.com>
Subject: Re: Linux-2.4.20-pre4-ac1: i810_audio broken
Date: Wed, 28 Aug 2002 10:04:07 +0300
User-Agent: KMail/1.4.6
Cc: linux-kernel@vger.kernel.org
References: <200208271253.12192.pavenis@latnet.lv> <20020827144629.E28828@redhat.com>
In-Reply-To: <20020827144629.E28828@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200208281004.07891.pavenis@latnet.lv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 August 2002 21:46, Doug Ledford wrote:
> On Tue, Aug 27, 2002 at 12:53:12PM +0300, Andris Pavenis wrote:
> > Found that i810_audio has been broken in kernel 2.4.20-pre4-ac1. It was
> > Ok with 2.4.20-pre1-ac1 I used before.
> >
> > With 2.4.20-pre4-ac1 I'm only getting garbled sound and kernel messages
> > (see below). Didn't have time yet to study mire detailed which change
> > breaks driver.
>
> The important part of my change is just two lines.  There is the line that
> prints out the message "Defaulting to base 2 channel mode." and the line
> after it where we mask off a couple bits in the global control register.
> Comment those two lines out and let me know if it makes a difference on
> your machine.
>
> > In Alan's changelog I see:
> >
> > 2.4.20-pre2-ac5: Further i810_audio updates for 845 (Juergen Sawinski)
> > 2.4.20-pre1-ac3: Tidy up error paths on i810_audio init (Alan)
> > 2.4.20-pre1-ac2: First set of i810 audio updates (Doug Ledford)

Verified that sound is already broken with 2.4.20-pre1-ac2, but works with
i810_audio.c from 2.4.19-pre1-ac1. Commenting 2 above mentioned lines out 
doesn't help

Andris
