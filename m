Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263854AbTETRIB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 13:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263859AbTETRIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 13:08:01 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:41671 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263854AbTETRIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 13:08:00 -0400
Date: Tue, 20 May 2003 18:24:28 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Brett <generica@email.com>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: CONFIG_VIDEO_SELECT stole my will to live
Message-ID: <20030520172428.GA32478@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	James Simmons <jsimmons@infradead.org>, Brett <generica@email.com>,
	linux-kernel@vger.kernel.org,
	linux-fbdev-devel@lists.sourceforge.net
References: <20030520155138.GA29450@suse.de> <Pine.LNX.4.44.0305201752240.28600-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305201752240.28600-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 05:55:41PM +0100, James Simmons wrote:


 > > Possibly the card's VGA BIOS has 'issues' with that call.
 > This is most likely the case. I just tested out the configuration he has 
 > and it worked for me. I'm running vga=5 right now. For teh majority it 
 > works but as usual there are some broken BIOS that cause issues. 

Or possibly..
It looks to me that the store_edid function is unconditionally calling
the READ EDID function without first having called the installation
check function. (Int 10h ax=4f15 bx=0)

Ralf Brown's interrupt list (which is pretty much definitive afaik)
also notes that for the READ EDID function, dx should be 0, we are
using 1. Is there a reason for this ?

		Dave

