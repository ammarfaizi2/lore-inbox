Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWGDLPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWGDLPD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 07:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWGDLPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 07:15:03 -0400
Received: from khc.piap.pl ([195.187.100.11]:28560 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751278AbWGDLPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 07:15:01 -0400
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	<20060701170729.GB8763@irc.pl>
	<20060701174716.GC24570@cip.informatik.uni-erlangen.de>
	<20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>
	<20060703205523.GA17122@irc.pl>
	<1151960503.3108.55.camel@laptopd505.fenrus.org>
	<44A9904F.7060207@wolfmountaingroup.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 04 Jul 2006 13:14:58 +0200
In-Reply-To: <44A9904F.7060207@wolfmountaingroup.com> (Jeff V. Merkey's message of "Mon, 03 Jul 2006 15:46:55 -0600")
Message-ID: <m3u05xhb9p.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" <jmerkey@wolfmountaingroup.com> writes:

> Add a salvagable file system to ext4, i.e. when a file is deleted, you
> just rename it and move it to a directory called DELETED.SAV and
> recycle the files as people allocate new ones.

Due to the problems pointed what would be really needed is a filesystem
with a full log of operations. Then the fs state (full contents of all
files etc.) at any given time can be restored.

May not be very efficient, though (probably people doing databases and
transaction logging have something to say). I'd rather have better
backups (so I can restore from them) instead of such logging.
-- 
Krzysztof Halasa
