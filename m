Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUIMDbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUIMDbM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 23:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUIMDbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 23:31:12 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:36482 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S265222AbUIMDat
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 23:30:49 -0400
Date: Mon, 13 Sep 2004 04:30:36 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Toon van der Pas <toon@hout.vanvergehaald.nl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Wolfpaw - Dale Corse <admin@wolfpaw.net>, kaukasoi@elektroni.ee.tut.fi,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial
 of Service Attack
In-Reply-To: <Pine.LNX.4.61.0409130413460.23011@fogarty.jakma.org>
Message-ID: <Pine.LNX.4.61.0409130425440.23011@fogarty.jakma.org>
References: <002301c498ee$1e81d4c0$0200a8c0@wolf> <1095008692.11736.11.camel@localhost.localdomain>
 <20040912192331.GB8436@hout.vanvergehaald.nl> <Pine.LNX.4.61.0409130413460.23011@fogarty.jakma.org>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004, Paul Jakma wrote:

> I think he means that BGP treating TCP connections as if they could 
> reliably and securely indicate link/path status (ie connection 
> reset/timeout == link down) status was, in retrospect, a very dumb 
> idea on the part of BGP.

More specifically, BGP should have treated TCP resets as a transient 
error, to be expected (indeed, they /cant/ be a sign that a link is 
down - if you can receive a RST the link or path is patently quite 
ok). The BGP state machine should instead, in normal operation, have 
only treated Hold time expired as the definitive sign of "peer is 
down" and allowed reconnects.

> regards,

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
You will attract cultured and artistic people to your home.
