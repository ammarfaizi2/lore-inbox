Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSHVRXm>; Thu, 22 Aug 2002 13:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSHVRXB>; Thu, 22 Aug 2002 13:23:01 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:5899 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S315276AbSHVRVn>; Thu, 22 Aug 2002 13:21:43 -0400
Date: Thu, 22 Aug 2002 19:22:34 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Holger Schurig <h.schurig@mn-logistik.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cell-phone like keyboard driver anywhere?
Message-ID: <20020822192234.E4679@nightmaster.csn.tu-chemnitz.de>
References: <200208210932.36132.h.schurig@mn-logistik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200208210932.36132.h.schurig@mn-logistik.de>; from h.schurig@mn-logistik.de on Wed, Aug 21, 2002 at 09:32:36AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Holger,

On Wed, Aug 21, 2002 at 09:32:36AM +0200, Holger Schurig wrote:
> I have to write a keyboard driver for a cell-phone like keyboard. I'm just 
> wondering if this has been done before.
> 
> However, this file (as any other that I have seen) assumes that there are 
> shift, ctrl, alt etc layers. But a cell-phone like keyboard operates 
> differently, e.g.
> 
> 1 pause -> send keycode for character "a"
> 1 1 pause -> send keycode for character "b"
> 1 1 1 pause -> send keycode for character "c"
> 2 pause -> send keycode for character "d"

This can be done with counting repeat count of the last key until we
reach the pause (done with a timer, that gets modified after each
key pressed).

If the pause is reached or after each key press you compute the
keycode character that will be sent now.

Cell phones usally do an replacement of the character until you
do the pause or push a different key.

So you would need to play console games, too (changing between
insert and replace mode).

Hope this helps.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
