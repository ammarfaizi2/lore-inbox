Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317889AbSFSOZh>; Wed, 19 Jun 2002 10:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317890AbSFSOZg>; Wed, 19 Jun 2002 10:25:36 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:33159 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S317889AbSFSOZg>; Wed, 19 Jun 2002 10:25:36 -0400
Date: Wed, 19 Jun 2002 16:22:45 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Robbert Kouprie <robbert@radium.jvb.tudelft.nl>
cc: linux-kernel@vger.kernel.org
Subject: RE: The buggy APIC of the Abit BP6
In-Reply-To: <005f01c21794$7702b520$020da8c0@nitemare>
Message-ID: <Pine.GSO.3.96.1020619160647.15094J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2002, Robbert Kouprie wrote:

> I know the hardware sucks bad, but what's wrong with trying to work
> around the problem providing noone else is bugged by the workaround?

 The reliability of the hardware is next to null.  You are not able to
recover from that.  You may succeed to recover from a subset of malformed
APIC messages, especially as losing an interrupt is often negligible, but
sooner or later you'll get hit by a corrupted IPI message, such as a TLB
flush and the system will either crash or produce wrong results.  Note
that APIC hardware already performs consistency checks on messages
exchanged, which are capable to filter out damaged ones.  If the hardware
fails to do that a message has to be seriously harmed. 

 Similarly you wouldn't like to work around occasional corruptions on your
host data bus, would you?

> The box already has an (overkill) 300W PSU, but yet I'm still seeing
> problems.

 Too bad.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

