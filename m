Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285304AbRLXURq>; Mon, 24 Dec 2001 15:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285305AbRLXURh>; Mon, 24 Dec 2001 15:17:37 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:53004 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S285304AbRLXUR1>;
	Mon, 24 Dec 2001 15:17:27 -0500
Date: Mon, 24 Dec 2001 21:17:26 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Data sitting and remaining in Send-Q
Message-ID: <20011224211726.H2461@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011224203828.G2461@lug-owl.de> <Pine.LNX.4.43.0112241507550.31883-100000@filesrv1.baby-dragons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0112241507550.31883-100000@filesrv1.baby-dragons.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-24 15:09:07 -0500, Mr. James W. Laferriere <babydr@baby-dragons.com>
wrote in message <Pine.LNX.4.43.0112241507550.31883-100000@filesrv1.baby-dragons.com>:
> 
> 	Hello Jan ,  Is this possibly related to a ECN enabled host &
> 	somewhere in between a Non-ECN enabled (or a cisco router) ?

That would give a different result: "functional TCP connections" or
"non-functional TCP connections". Mine are between that. If data gets
sent in small chunks, everything is fine, but if it's a larger
transfer (more than one ethernet frame may transport???), write()
stalls (or non-blocking write returns), but data is kept in
Send-Q rather than being sent down to the client.

Well, my setup is a LAN, everything here is fully functional wrt.
ECN. I've never switched ECN off, and 2.4.x is running since ages
on the boxes around. So it's definitely *not* ECN in this case:-(

MfG, JBG

-- 
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/
