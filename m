Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTG1LNn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 07:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTG1LNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 07:13:43 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8073
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263407AbTG1LNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 07:13:42 -0400
Subject: Re: i8042 problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Chris Heath <chris@heathens.co.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030727215545.A21295@devserv.devel.redhat.com>
References: <20030726093619.GA973@win.tue.nl>
	 <20030726212513.A0BD.CHRIS@heathens.co.nz>
	 <20030727020621.A11637@devserv.devel.redhat.com>
	 <20030727104726.GA1313@win.tue.nl>
	 <20030727215545.A21295@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059391505.15440.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jul 2003 12:25:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-28 at 02:55, Pete Zaitcev wrote:
> > Date: Sun, 27 Jul 2003 12:47:26 +0200
> > From: Andries Brouwer <aebr@win.tue.nl>
> 
> > So the culprit is the failing of atkbd_probe().
> > It does a ATKBD_CMD_GETID, but gets no answer, then a
> > ATKBD_CMD_SETLEDS, and that command fails.
> 
> I see the light now. Somehow I imagined that atkbd code does not call
> the ->open for the port. Now it all falls into place. Everything works
> with a bigger timeout.

Unfortunately with this change several people still report failures

