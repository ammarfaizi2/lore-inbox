Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129912AbQK3SO5>; Thu, 30 Nov 2000 13:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130032AbQK3SOr>; Thu, 30 Nov 2000 13:14:47 -0500
Received: from ns.tasking.nl ([195.193.207.2]:58374 "EHLO ns.tasking.nl")
        by vger.kernel.org with ESMTP id <S129555AbQK3SOk>;
        Thu, 30 Nov 2000 13:14:40 -0500
Date: Thu, 30 Nov 2000 18:42:09 +0100
From: Dick Streefland <dick.streefland@tasking.com>
To: Robert Schiele <rschiele@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11: es1371 mixer problems
Message-ID: <20001130184209.A17335@kemi.tasking.nl>
In-Reply-To: <20001124135956.A5842@kemi.tasking.nl> <20001130134725.A12437@kemi.tasking.nl> <20001130182428.A2127@schiele.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i (Linux)
In-Reply-To: <20001130182428.A2127@schiele.priv>; from rschiele@uni-mannheim.de on Thu, Nov 30, 2000 at 06:24:28PM +0100
Organization: TASKING Software BV, Amersfoort, The Netherlands
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 2000-11-30 18:24, Robert Schiele wrote:
| On Thu, Nov 30, 2000 at 01:47:25PM +0100, Dick Streefland wrote:
| > This mixer probably replaces the normal AC97 mixer device. So, in
| > what situations do you need CONFIG_SOUND_TVMIXER? It would be nice if
| > someone could come up with an entry for Documentation/Configure.help.
| 
| In fact it does not 'replace' the other mixer device, but it adds
| another one. The problem on your system is, that you load the new
| module before your sound card module.
| This means with only your sound card module, the mixer for your sound
| card is major 14/minor 0. With tvmixer module loaded before your sound
| card module, major 14/minor 0 is assigned to tvmixer and your sound
| card mixer gets major 14/minor 16. This is a problem for some mixer
| applications, because they always control the first mixer device.
| So you should just make sure, your sound card module is loaded
| _before_ the tvmixer module.

OK, that makes it somewhat clearer to me. However, I don't use modules
and have everything compiled in, so I can't control the order in which
the mixer devices get loaded. Perhaps the initialization order in the
kernel should be changed?

Excuse my ignorance, but what exactly is the purpose of the tvmixer?
I'm currently controlling the TV audio volume with the ac97 mixer,
using an external cable between the TV card and sound card.

-- 
Dick Streefland                      ////            TASKING Software BV
dick.streefland@tasking.com         (@ @)         http://www.tasking.com
--------------------------------oOO--(_)--OOo---------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
