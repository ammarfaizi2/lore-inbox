Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263305AbTJ0RT7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 12:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTJ0RT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 12:19:59 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:20938 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263305AbTJ0RT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 12:19:58 -0500
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>
Cc: "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Hans Reiser '" <reiser@namesys.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, <linux-kernel@vger.kernel.org>,
       <nikita@namesys.com>, "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Vitaly Fertman '" <vitaly@namesys.com>
Subject: Re: Blockbusting news, results end
References: <785F348679A4D5119A0C009027DE33C105CDB39C@mcoexc04.mlm.maxtor.com>
	<3cbb01c39c6f$17608410$24ee4ca5@DIAMONDLX60>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 27 Oct 2003 11:48:57 +0100
In-Reply-To: <3cbb01c39c6f$17608410$24ee4ca5@DIAMONDLX60>
Message-ID: <m3u15vdkh2.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Norman Diamond" <ndiamond@wta.att.ne.jp> writes:

> Bingo.  This is why reallocation at the time of a failed read is also
> necessary.  Yes the data are lost, yes the failure needs to be both logged
> (once)

The log entry may be easily lost. Especially when the drive is failing.

> and displayed to the user (once),

To which user??? Hard drive sectors have no users.

> yes if an application reads it
> again before writing then it will be garbage or zeroes,

I hope drive makers won't take it seriously.

> but get the LBA
> sector number moved to a place that is less likely to be unreliable.

So you rather want to read garbage than get a real I/O error.
The only situation I can imagine which benefits from such an approach
is playing an audio-video stream.

> Meanwhile software must still make up for defective firmware.

Yeah. yeah. Only "if (drive_is_toshiba()) BUG()" comes to my mind.
-- 
Krzysztof Halasa, B*FH
