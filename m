Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265597AbUBFTzJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 14:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265602AbUBFTzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 14:55:08 -0500
Received: from almesberger.net ([63.105.73.238]:30731 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S265597AbUBFTzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 14:55:03 -0500
Date: Fri, 6 Feb 2004 16:54:58 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS locking: f_pos thread-safe ?
Message-ID: <20040206165458.D18820@almesberger.net>
References: <402359E1.6000007@ntlworld.com> <20040206011630.42ed5de1.akpm@osdl.org> <40235DCC.2060606@ntlworld.com> <20040206013523.394d89f1.akpm@osdl.org> <pan.2004.02.06.10.19.57.885433@smurf.noris.de> <20040206111853.GE21151@parcelfarce.linux.theplanet.co.uk> <pan.2004.02.06.18.59.44.936432@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.02.06.18.59.44.936432@smurf.noris.de>; from smurf@smurf.noris.de on Fri, Feb 06, 2004 at 07:59:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Urlichs wrote:
> but it's NOT AT ALL obvious to a "normal" application programmer.

It gets worse. From the same draft (perhaps someone who has the final
version could comment ?), in the rationale for read():

| The standard developers considered adding atomicity requirements to a
| pipe or FIFO, but recognized that due to the nature of pipes and FIFOs
| there could be no guarantee of atomicity of reads of {PIPE_BUF} or any
| other size that would be an aid to applications portability.

But then

| I/O is intended to be atomic to ordinary files and pipes and FIFOs.

Now, what exactly does "intended" mean ?

Of course, in this part, they only talk about data staying together,
not whether it can get duplicated, or effects on f_pos.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
