Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267182AbUG1Osm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267182AbUG1Osm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 10:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267185AbUG1Osm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 10:48:42 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:63241 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S267182AbUG1Osk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 10:48:40 -0400
Date: Wed, 28 Jul 2004 16:47:23 +0200
From: DervishD <raul@pleyades.net>
To: Markus Schaber <schabios@logi-track.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The dreadful CLOSE_WAIT
Message-ID: <20040728144723.GA32602@DervishD>
Mail-Followup-To: Markus Schaber <schabios@logi-track.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20040727083947.GB31766@DervishD> <4106869A.5030905@sun.com> <20040727170907.GA26136@DervishD> <20040728140622.2bc69fa5@kingfisher.intern.logi-track.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040728140622.2bc69fa5@kingfisher.intern.logi-track.com>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Markus :)

 * Markus Schaber <schabios@logi-track.com> dixit:
> >     I know, that's the only 'harm' a CLOSE_WAIT timeout will have,
> > but anyway I don't see any point in having a permanent CLOSE_WAIT
> > state. The other end is not there, it has sent us a FIN.
> Yes, but it may still want to read.

    I know, now I understand.

> >     Well, it may be an idea ;) Anyway if you have, let's say, a
> > maximum of 10 connections in your server, and I do 10 wget+C-c, you
> > no longer have a running server. The kernel should not allow that. A
> > timeout of 3600 seconds seems very reasonable, or somethink like
> > that, am I wrong?
> Well, when the other side is really dead, then connection keepalive
> should detect that (when enabled), by either timeout or getting a reset
> packet.

    But this must be enabled in the application, am I wrong? using
SO_KEEPALIVE. Can it be enabled using sysctl or the like.

    Thanks for the information. When I saw the transitions, I thought
that the server got the FIN after the client died, but obviously it
can get it when the client doesn a half-close, and I didn't think of
it. Thanks, Markus :)

    Now, is there any sysctl that enables a keepalive for this kind
of connections (dead remote end, local in CLOSE_WAIT) for all
connections?
    
    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
