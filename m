Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272125AbTGYOZU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 10:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272126AbTGYOZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 10:25:19 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:29855 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S272125AbTGYOZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 10:25:14 -0400
Date: Fri, 25 Jul 2003 10:29:26 -0400
From: Ben Collins <bcollins@debian.org>
To: Sam Bromley <sbromley@cogeco.ca>, Torrey Hoffman <thoffman@arnor.net>,
       gaxt <gaxt@rogers.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030725142926.GD1512@phunnypharm.org>
References: <20030724223615.GN1512@phunnypharm.org> <20030724230928.GB23196@ruvolo.net> <1059095616.1897.34.camel@torrey.et.myrio.com> <20030725012723.GF23196@ruvolo.net> <20030725012908.GT1512@phunnypharm.org> <1059103424.24427.108.camel@daedalus.samhome.net> <20030725041234.GX1512@phunnypharm.org> <20030725053920.GH23196@ruvolo.net> <20030725133438.GZ1512@phunnypharm.org> <20030725142907.GI23196@ruvolo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725142907.GI23196@ruvolo.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> What does no_waiter indicate?  That a packet should not have a response?
> 

Yeah. Which is usually the case for a successful ack packet. Something
is clearing the list of pending packets, but I'm not sure what. Please
revert the patches thus far and apply this patch. It should tell us
where pending_packets is getting changed.

My best guess right now is that abort_timedouts is killing packets from
the pending list too quickly. We'll cross that bridge when we see the
results here.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
