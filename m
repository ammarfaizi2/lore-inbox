Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132571AbRDQGl7>; Tue, 17 Apr 2001 02:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132573AbRDQGls>; Tue, 17 Apr 2001 02:41:48 -0400
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:37514 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S132571AbRDQGlg>; Tue, 17 Apr 2001 02:41:36 -0400
Date: Tue, 17 Apr 2001 08:41:30 +0200 (CEST)
From: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'Pavel Machek'" <pavel@suse.cz>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        <linux-kernel@vger.kernel.org>
Subject: RE: Let init know user wants to shutdown
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE843@orsmsx35.jf.intel.com>
Message-Id: <Pine.LNX.4.31.0104170827510.6365-100000@phobos.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2001, Grover, Andrew wrote:

> > From: Pavel Machek [mailto:pavel@suse.cz]
> > There are 32 signals, and signals can carry more information, if
> > required. I really think doing it way UPS-es are done is right
> > approach.

> I would think that it would make sense to keep shutdown with all the other
> power management events. Perhaps it will makes more sense to handle UPS's
> through the power management code.

I've already started to like the idea, since init is the tool that runs
all the time, not any ACPI or PM daemon, and it seems good to me that the
kernel always knows what to do on an event (signal init and think that it
has been dealt with).

init should provide a "direct" interface that doesn't rely on scripts
being present in certain directories (one less thing that can be broken)
for programs that want to receive these events. From the application
programmer's view this doesn't even make a difference if you have a shlib.

Maybe we should copy the init people? :-)

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: DC26 EB8D 1F35 4F44 2934  7583 DBB6 F98D 9198 3292
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!

