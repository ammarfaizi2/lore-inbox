Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTFFPL0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 11:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbTFFPL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 11:11:26 -0400
Received: from mail.ithnet.com ([217.64.64.8]:18182 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S261411AbTFFPLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 11:11:25 -0400
Date: Fri, 6 Jun 2003 17:24:54 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: short freezing while file re-creation
Message-Id: <20030606172454.6f3cbeed.skraw@ithnet.com>
In-Reply-To: <20030606091759.GC23608@namesys.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030606091759.GC23608@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oleg,

while experimenting around my other problem I noticed my box freezes for some
seconds while tar is re-creating an archive of around 70 GB size on a reiserfs
with 3ware-connected device.
This is experienced with 2.4.21-rc7. Reproducable via:

create BIG tar archive file (my size 70 GB) on a reiserfs
re-create same archive and watch box gone dead while the old archive is zapped.
(Gone dead means: mouse froze, keyboard froze, X froze)
The effect is visible for several seconds, then everything is back to normal.
It's no big deal if you are interactively dealing with the cause (tar). But if
you deal with background processes in server environment where your primary
process goes suddenly dead for seconds you are probably not amused...
Can you verify this? Is this device or fs dependant?

Regards,
Stephan
