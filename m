Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271699AbTHRMWs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271701AbTHRMWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:22:48 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:27570 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S271699AbTHRMWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:22:44 -0400
Date: Mon, 18 Aug 2003 14:22:35 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Jamie Lokier <jamie@shareable.org>, Andries Brouwer <aebr@win.tue.nl>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
In-Reply-To: <20030817215436.GA24933@ucw.cz>
Message-ID: <Pine.GSO.3.96.1030818135400.12013B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Aug 2003, Vojtech Pavlik wrote:

> > What are the known problems with mode #3, then?
> 
> It's broken on many keyboards (on some only slightly, like some keys not
> working properly). Other (special, either unix workstation or point of
> sale) keyboards need it to work properly.

 IIRC, OSF/1 running on later Alphas with a PS/2 keyboard interface
(earlier oned had an LK201 one) uses mode #3.  I can't comment on the VMS.

> > That is, why doesn't everyone use it and why haven't they always used it?
> 
> Because old AT keyboards didn't support it. Because the XT keyboard
> didn't support it. Because history sticks.

 Since the 8042+keyboard combo supports a PC/XT compatibility mode there
was no incentive -- why bother modifying software if the hardware works
with the old one?  Even if that sucks. 

> > For that matter, what does Windows use?
> 
> Translated Set 2. Actually an emulated XT keyboard.

 For mode #3 explicit handling for hot-plugging would be required -- I
guess the change would be much too intrusive.  And untranslated mode #2 is
nearly the same as an emulated PC/XT keyboard: codes are different and the
release bit is replaced by the release code, but the multibyte mess for
PS/2-specific keys remains -- no gain at all.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

