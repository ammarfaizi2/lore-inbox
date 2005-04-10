Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVDJRYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVDJRYu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 13:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVDJRYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 13:24:50 -0400
Received: from stingr.net ([212.193.32.15]:39560 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S261527AbVDJRYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 13:24:37 -0400
Date: Sun, 10 Apr 2005 21:24:21 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Martin Pool <mbp@sourcefrog.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       David Lang <dlang@digitalinsight.com>
Subject: Code snippet to reconstruct ancestry graph from bk repo
Message-ID: <20050410172421.GA7716@stingr.stingr.net>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>, Martin Pool <mbp@sourcefrog.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Lang <dlang@digitalinsight.com>
References: <20050407014727.GA17970@havoc.gtf.org> <pan.2005.04.07.02.25.56.501269@sourcefrog.net> <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz> <1112852302.29544.75.camel@hope> <Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org> <1112939769.29544.161.camel@hope> <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org> <20050408083839.GC3957@opteron.random> <Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org> <Pine.LNX.4.61.0504091547320.15339@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504091547320.15339@scrub.home>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Roman Zippel:
> the "nitty-gritty" I was "whining" about and which is not available via 
> bkcvs or bkweb and it's the most crucial information to make the bk data 
> useful outside of bk. Larry was previously very clear about this that he 
> considers this proprietary bk meta data and anyone attempting to export 
> this information is in violation with the free bk licence, so you indeed 
> just took the important parts and this is/was explicitly verboten for 
> normal bk users.

(borrowed from Tommi Virtanen)

Code snippet to reconstruct ancestry graph from bk repo:
bk changes -end':I: $if(:PARENT:){:PARENT:$if(:MPARENT:){ :MPARENT:}} $unless(:PARENT:){-}'         |tac

format is:
newrev parent1 [parent2]
parent2 present if merge occurs.

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
