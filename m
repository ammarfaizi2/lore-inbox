Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTFXK74 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 06:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTFXK74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 06:59:56 -0400
Received: from almesberger.net ([63.105.73.239]:13574 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261928AbTFXK7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 06:59:54 -0400
Date: Tue, 24 Jun 2003 08:13:19 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, John Coffman <johninsd@san.rr.com>
Subject: Re: Kernel & BIOS return differing head/sector geometries
Message-ID: <20030624081319.G1326@almesberger.net>
References: <20030624010906.08ad32f3.ktech@wanadoo.es> <20030624013908.B1133@pclin040.win.tue.nl> <bd8hgj$cas$1@cesium.transmeta.com> <20030624012220.E1418@almesberger.net> <3EF7D33E.6060009@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF7D33E.6060009@zytor.com>; from hpa@zytor.com on Mon, Jun 23, 2003 at 09:27:42PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Presumably "linear", not "lba32".  I *presume* LILO has enough 
> wherewithal to use EBIOS if it's available and fall back to CBIOS 
> otherwise for at least one of these options.  I at least thought "lba32" 
> would force EBIOS usage.

Yes, that seems to be the case. (All the LBA32 code is from John
Coffman. I've copied him in case he's interested in the thread.)
But you're still betting on the BIOS to either implement EDD
correctly, or at least to report that it doesn't support it.

Call me paranoid, but I wouldn't be at all surprised if there are
some BIOSes out there that get this wrong.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
