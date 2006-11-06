Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423247AbWKFCsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423247AbWKFCsU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 21:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423265AbWKFCsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 21:48:20 -0500
Received: from pop-satin.atl.sa.earthlink.net ([207.69.195.63]:43258 "EHLO
	pop-satin.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1423247AbWKFCsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 21:48:19 -0500
Message-ID: <454EA263.4090008@cfl.rr.com>
Date: Sun, 05 Nov 2006 21:48:03 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Brad Campbell <brad@wasp.net.au>
CC: James Courtier-Dutton <James@superbug.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Albert Cahalan <acahalan@gmail.com>, kangur@polcom.net,
       mikulas@artax.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
References: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com> <1162691856.21654.61.camel@localhost.localdomain> <454DC799.9000401@superbug.co.uk> <454DCAAC.3080903@wasp.net.au>
In-Reply-To: <454DCAAC.3080903@wasp.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Campbell wrote:
> I've never seen this behaviour in a drive. All the drives I've seen mark 
> bad sectors as "pending reallocation", they they return read errors on 
> that sector unless they manage to jag a good read, in which case they 
> then reallocate the sector. Or else they wait for you to write to the 
> sector triggering a reallocation.
> 

This is exactly what they are required to do by the relevant standards. 
  The drive can not silently discard data and reallocate the sector.  It 
either has to get a successful read of the old data, then reallocate, or 
wait for the host to write new data, and store that in the new location.


