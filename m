Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129944AbQLSSKe>; Tue, 19 Dec 2000 13:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130204AbQLSSKY>; Tue, 19 Dec 2000 13:10:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27909 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129944AbQLSSKM>; Tue, 19 Dec 2000 13:10:12 -0500
Date: Tue, 19 Dec 2000 18:39:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: Kurt Garloff <garloff@suse.de>, "Theodore Y. Ts'o" <tytso@MIT.EDU>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: /dev/random: really secure?
Message-ID: <20001219183931.A21553@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20001218213801.A19903@pcep-jamie.cern.ch> <200012182133.QAA02136@tsx-prime.MIT.EDU> <20001219124948.P17777@garloff.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20001219124948.P17777@garloff.suse.de>; from garloff@suse.de on Tue, Dec 19, 2000 at 12:49:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Mon, Dec 18, 2000 at 04:33:13PM -0500, Theodore Y. Ts'o wrote:
> > Note that writing to /dev/random does *not* update the entropy estimate,
> > for this very reason.  The assumption is that inputs to the entropy
> > estimator have to be trusted, and since /dev/random is typically
> > world-writeable, it is not so trusted.
> 
> It should not be world-writeable, IMHO. So the only one who can feed entropy
> there is root, who should know aht (s)he's doing ...
> Here (SuSE Linux 7.x), it is 644:

You actually *want* random people to send entropy into your pool. Just
do not increase counters. That way, entropy can only get better :-).
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
