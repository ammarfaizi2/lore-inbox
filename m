Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270633AbTHAAdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 20:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270636AbTHAAdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 20:33:22 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:24757
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S270633AbTHAAdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 20:33:17 -0400
Subject: [SHED][IO-SHED] Are we missing the big picture?
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Cc: pomac@vapor.com
Content-Type: text/plain
Message-Id: <1059697921.30747.54.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 01 Aug 2003 02:32:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have been following the sheduler and interactivity discussions closely
but via the marc.theaimsgroup.com archive, So i might be behind etc...
=P

[Note: sorry if i sound like mr.know-it-all etc, just trying to get a
point across]

Anyways, i think that the AS discussions that i have seen has missed
some points. Getting the processes priority in AS is one thing, but fist
of all i think there should be a stand off layer. Let me explain:

I liked Jens Axobe's 'CBQ' alike implementation (based on the idea of
Andrea A. (afair i have the names right) since it does the most
important thing... which is *nothing* when there is no load (ie, pass
trough).

AS might be/is the best damn io sheduler for loaded machines but when
there is no load, it's overhead. So in my opinion there should be
something that first warrants the usage of AS before it's actually
engaged.

And, if it's only engaged during high load, additions like basing the
requests priority on the process/tasks priority would make total sense,
adding the 'wakeup on wait' or what it was would also make total
sense... But how many of your machines uses the disk 100% of the time?
(in the real world... )

I don't know how 'CBQ' was implemented but any 'we are under load now'
trigger would do it for me.

Please see to it that my CC is included in any discussions =)

PS. Or was it a version of SFQ? in that case s/CBQ/SFQ/g
DS.

-- 
Ian Kumlien <pomac@vapor.com>

