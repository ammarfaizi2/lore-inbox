Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWBTLR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWBTLR3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 06:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWBTLR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 06:17:29 -0500
Received: from canadatux.org ([81.169.162.242]:49099 "EHLO
	zoidberg.canadatux.org") by vger.kernel.org with ESMTP
	id S932490AbWBTLR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 06:17:28 -0500
Date: Mon, 20 Feb 2006 12:17:24 +0100
From: Matthias Hensler <matthias@wspse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220111724.GB22552@kobayashi-maru.wspse.de>
Reply-To: Matthias Hensler <matthias@wspse.de>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz> <200602200709.17955.nigel@suspend2.net> <20060219212952.GI15311@elf.ucw.cz> <20060220094300.GC19293@kobayashi-maru.wspse.de> <20060220103616.GC16042@elf.ucw.cz> <20060220105016.GA22552@kobayashi-maru.wspse.de> <20060220105406.GE16042@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060220105406.GE16042@elf.ucw.cz>
Organization: WSPse (http://www.wspse.de/)
X-Gummibears: Bouncing here and there and everywhere
X-Face: &Tv]9SsNpb/$w8\G-O%>W02aApFW^P>[x+Upv9xQB!2;iD9Y1-Lz'qlc{+lL2Y>J(u76Jk,cJ@$tP2-M%y?^'jn2J]3C'ss_~"u?kA^X&{]h?O?@*VwgSGob73I9r}&S%ktup0k2!neScg3'HO}PU#Ac>jwNL|P@f|f*sz*cP'hi)/<JQC4|Q[$D@aQ"C{$>a=6.rc-P1vXarjVXlzClmNfcSy/$4tQz
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, Feb 20, 2006 at 11:54:06AM +0100, Pavel Machek wrote:
> On Po 20-02-06 11:50:16, Matthias Hensler wrote:
> > OK, could you point me to the ugly thinks. I see message passing
> > between the userspace application and the kernel, for which I think
> > that netlink is a good choice.
> 
> See my comments in "suspend2 review" thread.

Yes, I read it. Nigel already replied and pointed out that a lot of
things were already fixed and will now be. So the effort to make the
patch acceptable is there.

However, about the User-UI stuff and some things that are implemented in
the kernel, I have to disagree with you. Suspend 2 happily works without
having the userspace UI, which is a good thing as it allows a minimal
setup and a small initrd.

But besides the progress bar I think that some parts have to be in the
kernel, such as the warnings and keyevents to abort the progress. If,
for whatever reason, something goes wrong, you should be able to stop
and abort before doing any damage. If all these things are implemented
in userspace, you need to have a binary in your initrd on the right
place, where is should work without that.

Regards,
Matthias
