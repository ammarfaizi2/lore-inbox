Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267552AbTALWKf>; Sun, 12 Jan 2003 17:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267553AbTALWKf>; Sun, 12 Jan 2003 17:10:35 -0500
Received: from vitelus.com ([64.81.243.207]:61712 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S267552AbTALWKd>;
	Sun, 12 Jan 2003 17:10:33 -0500
Date: Sun, 12 Jan 2003 14:18:49 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Oliver Neukum <oliver@neukum.name>
Cc: robw@optonline.net, Rik van Riel <riel@conectiva.com.br>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030112221849.GO31238@vitelus.com>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <Pine.LNX.4.50L.0301121939170.26759-100000@imladris.surriel.com> <1042407845.3162.131.camel@RobsPC.RobertWilkens.com> <200301122312.41879.oliver@neukum.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301122312.41879.oliver@neukum.name>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 11:12:41PM +0100, Oliver Neukum wrote:
> Yes. Typical error cleanup looks like:
> err_out:
> 	up(&sem);
> 	return err;
> 
> Releasing a lock in another function is a crime punished by slow death.

Not to mention that the 'return err;' statement is hard to move to an
inline function meaningfully.
