Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbTEJObI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 10:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbTEJObI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 10:31:08 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:9989 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264262AbTEJObH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 10:31:07 -0400
Date: Sat, 10 May 2003 15:43:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: Francois Romieu <romieu@fr.zoreil.com>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [ATM] [UPDATE] unbalanced exit path in Forerunner HE he_init_one() (and an iphase patch too!)
Message-ID: <20030510154346.A4032@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	chas williams <chas@locutus.cmf.nrl.navy.mil>,
	Francois Romieu <romieu@fr.zoreil.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20030510062015.A21408@infradead.org> <200305101352.h4ADqoGi014392@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305101352.h4ADqoGi014392@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Sat, May 10, 2003 at 09:52:49AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 09:52:49AM -0400, chas williams wrote:
> class/usb-midi.c:       if ( u ) kfree(u);
> class/usblp.c:          if (usblp->statusbuf) kfree(usblp->statusbuf);
> class/usblp.c:          if (usblp->device_id_string) kfree(usblp->device_id_string);
> image/mdc800.c:#define try_free_mem(A)  if (A != 0) { kfree (A); A=0; }

It's wrong there, too.  usb is not exactly the right example if you look
for code that matches the style guidelines..
