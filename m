Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129169AbRBBUeK>; Fri, 2 Feb 2001 15:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129178AbRBBUdu>; Fri, 2 Feb 2001 15:33:50 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:12916 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S129169AbRBBUdm>; Fri, 2 Feb 2001 15:33:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14971.6559.195525.434368@somanetworks.com>
Date: Fri, 2 Feb 2001 15:33:35 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: "Michael B. Trausch" <fd0man@crosswinds.net>
Cc: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Modules and DevFS
In-Reply-To: <Pine.LNX.4.21.0102021453560.27604-100000@fd0man.accesstoledo.com>
In-Reply-To: <3A7A8D6D.2C13D5EB@idb.hist.no>
	<Pine.LNX.4.21.0102021453560.27604-100000@fd0man.accesstoledo.com>
X-Mailer: VM 6.75 under 21.2  (beta40) "Persephone" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "MBT" == Michael B Trausch <fd0man@crosswinds.net> writes:

 MBT> Is this fixable the "right" way?

On my box, which started its life as a RH7, I've been editing
/etc/security/console.perms as I've discovered problems.

I don't know if this is the right way but thus far I've:

 - changed the <console> line to read:

<console>=tty[0-9][0-9]* vc/[0-9][0-9]* :[0-9]\.[0-9] :[0-9]

   (just added the vc/... pattern)

 - changed the <cdrom> line to read:

<cdrom>=/dev/cdroms/* /dev/cdwriter*

   (removed the /dev/cdrom* and added /dev/cdroms/*)

I have not had reason (ie. xmms works) to change the sound settings,
which are:

<sound>=/dev/dsp* /dev/audio* /dev/midi* \
        /dev/mixer* /dev/sequencer

Hope that helps.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
