Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266853AbUHITIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266853AbUHITIi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266897AbUHIS7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:59:36 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:28738 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266885AbUHIS6p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:58:45 -0400
Date: Mon, 9 Aug 2004 21:00:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] Host Virtual Serial Interface driver
Message-ID: <20040809190042.GB20397@mars.ravnborg.org>
Mail-Followup-To: Hollis Blanchard <hollisb@us.ibm.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	viro@parcelfarce.linux.theplanet.co.uk
References: <1091827384.31867.21.camel@localhost> <20040809184859.GA20397@mars.ravnborg.org> <200408091351.49211.hollisb@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091351.49211.hollisb@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 01:51:49PM -0500, Hollis Blanchard wrote:
> >
> > pr_debug is a noop if DEBUG is not defined. Make dump_hex, dump_packet
> > be a noop also and you get rid of several #ifdef in the code.
> 
> I'd like to do that, but notice that dump_hex() is called from dump_packet() 
> from hvsi_recv_response() (and I've just made hvsi_recv_control() the same). 
> Even with debug disabled, I'd like to be able to dump a whole packet if I get 
> confused...

Make a small wrapper that becomes noop in non-debug case,
and use the real one where you do not care about DEBUG.

	Sam
