Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265105AbSJaCXF>; Wed, 30 Oct 2002 21:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265106AbSJaCXF>; Wed, 30 Oct 2002 21:23:05 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:32783 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265105AbSJaCXE>; Wed, 30 Oct 2002 21:23:04 -0500
Date: Thu, 31 Oct 2002 02:29:23 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.45 CONFIG_INET=n broken due to secpath_put()
Message-ID: <20021031022923.GA1313@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *18755H-000JHv-00*mumGxHg2qtU* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


core/skbuff.c:__kfree_skb() tries to do secpath_put(), which
calls __secpath_destroy(), which is only built when CONFIG_INET=y

regards
john

-- 
""All the people we like are We, and everyone else is They."
	- Kipling
