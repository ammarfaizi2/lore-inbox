Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266896AbUHITAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUHITAV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266871AbUHITAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:00:12 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:60133 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266896AbUHIS4g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:56:36 -0400
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] Host Virtual Serial Interface driver
Date: Mon, 9 Aug 2004 13:51:49 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
References: <1091827384.31867.21.camel@localhost> <20040809184859.GA20397@mars.ravnborg.org>
In-Reply-To: <20040809184859.GA20397@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408091351.49211.hollisb@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 August 2004 13:48, Sam Ravnborg wrote:
> > #warning here
>
> This "#warning" should be deleted..

Right, sorry. A bookmark... :)

> > #ifdef DEBUG
> > 	pr_debug("%s: sending %i bytes\n", __FUNCTION__, packet.len);
> > 	dump_hex((uint8_t*)&packet, packet.len);
> > #endif
>
> pr_debug is a noop if DEBUG is not defined. Make dump_hex, dump_packet
> be a noop also and you get rid of several #ifdef in the code.

I'd like to do that, but notice that dump_hex() is called from dump_packet() 
from hvsi_recv_response() (and I've just made hvsi_recv_control() the same). 
Even with debug disabled, I'd like to be able to dump a whole packet if I get 
confused...

-- 
Hollis Blanchard
IBM Linux Technology Center
