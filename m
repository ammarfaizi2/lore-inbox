Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVCUHsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVCUHsE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 02:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVCUHsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 02:48:04 -0500
Received: from thunk.org ([69.25.196.29]:56038 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261640AbVCUHsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 02:48:02 -0500
Date: Mon, 21 Mar 2005 02:17:25 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org
Subject: Re: Relayfs question
Message-ID: <20050321071725.GB26839@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0503191852520.21324@yvahk01.tjqt.qr> <423C78E8.3040200@ev-en.org> <Pine.LNX.4.61.0503192014520.14144@yvahk01.tjqt.qr> <423C913B.6000307@opersys.com> <Pine.LNX.4.61.0503192155240.6141@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503192155240.6141@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2005 at 10:08:13PM +0100, Jan Engelhardt wrote:
> 
> Well, what about things like urandom? It also moves "a lot" of data and does
> nothing else.
> 

If you're using urandom to move "a lot" of data, you're using it
wrong.  That's not what it is supposed to be for; I can't think of a
valid use of /dev/urandom that would use more than, say, 256 bytes
(2048 bits), and most sanely written users of /dev/urandom only need
16 bytes (i.e., 128 bits).  Anything more than that, and you should be
using a userpsace PRNG or CRNG, and **not** /dev/urandom.

						- Ted
