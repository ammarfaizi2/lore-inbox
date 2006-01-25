Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWAYRTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWAYRTX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 12:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWAYRTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 12:19:23 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:29141 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750861AbWAYRTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 12:19:22 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 25 Jan 2006 18:18:23 +0100
To: mrmacman_g4@mac.com, matthias.andree@gmx.de
Cc: schilling@fokus.fraunhofer.de, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D7B2DF.nailDFJA51SL1@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B075.6000602@gmx.de>
In-Reply-To: <43D7B075.6000602@gmx.de>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> > Irrelevant to the discussion at hand, we are talking only about linux 
> > and what should be done on linux.
>
> Well, cdrecord relies on libscg, so in effect most of the portability code
> that is affected is in libscg; some of the real-time code however is
> specific to cdrecord.

This is correct, as (looking at other programs from cdrtools) cdrecord is the 
only program that needs realtime scheduling.


> So I'll repeat my question: is there anything that SG_IO to /dev/hd* (via
> ide-cd) cannot do that it can do via /dev/sg*? Device enumeration doesn't count.

But device enumeration is the central point when implementing -scanbus.

Note that all OS that I am aware of internally use a device enumeration scheme 
that is close to what libscg uses. This ie even true for Linux. If Linux did not
hide this information for /dev/hd* based fd's, I could implement an abstraction
layer.....

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
