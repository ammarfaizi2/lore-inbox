Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129555AbQK3NTz>; Thu, 30 Nov 2000 08:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129636AbQK3NTp>; Thu, 30 Nov 2000 08:19:45 -0500
Received: from ns.tasking.nl ([195.193.207.2]:1038 "EHLO ns.tasking.nl")
        by vger.kernel.org with ESMTP id <S129555AbQK3NTb>;
        Thu, 30 Nov 2000 08:19:31 -0500
Date: Thu, 30 Nov 2000 13:47:25 +0100
From: Dick Streefland <dick.streefland@tasking.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11: es1371 mixer problems
Message-ID: <20001130134725.A12437@kemi.tasking.nl>
In-Reply-To: <20001124135956.A5842@kemi.tasking.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i (Linux)
In-Reply-To: <20001124135956.A5842@kemi.tasking.nl>; from dick.streefland@tasking.com on Fri, Nov 24, 2000 at 01:59:57PM +0100
Organization: TASKING Software BV, Amersfoort, The Netherlands
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dick Streefland <dick.streefland@tasking.com> wrote:
| 2.4.0-test11 introduced a problem with the mixer device of my SB128
| soundcard (es1371 driver). When I start a mixer application like
| xmixer or aumix, only a small subset of the mixer devices are available.
| With 2.4.0-test10, using the same .config, all devices are available.

This is a followup to my own message to report that the mixer is
working again after I disabled the CONFIG_SOUND_TVMIXER option. I
don't know what exactly this option does (no help text), but since I
have a Hauppauge (BT878) TV-card, I did enable this option. In
test11, drivers/media/video/tvmixer.c was modified so that it now
looks for tvmixer devices, and it actually finds one:

  tvmixer: debug: MSP3415D-A2 
  tvmixer: MSP3415D-A2 (bt848 #0) registered with minor 0 
  tvmixer: debug: (unset) 

This mixer probably replaces the normal AC97 mixer device. So, in
what situations do you need CONFIG_SOUND_TVMIXER? It would be nice if
someone could come up with an entry for Documentation/Configure.help.

-- 
Dick Streefland                      ////            TASKING Software BV
dick.streefland@tasking.com         (@ @)         http://www.tasking.com
--------------------------------oOO--(_)--OOo---------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
