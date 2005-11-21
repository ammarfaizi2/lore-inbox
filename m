Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbVKUNCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVKUNCr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 08:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVKUNCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 08:02:47 -0500
Received: from p-mail2.rd.francetelecom.com ([195.101.245.16]:30990 "EHLO
	p-mail2.rd.francetelecom.com") by vger.kernel.org with ESMTP
	id S932292AbVKUNCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 08:02:46 -0500
Message-ID: <4381C56F.106@francetelecom.com>
Date: Mon, 21 Nov 2005 14:02:39 +0100
From: VALETTE Eric RD-MAPS-REN <eric2.valette@francetelecom.com>
Reply-To: eric2.valette@francetelecom.com
Organization: Frnace Telecom R&D
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sfrench@us.ibm.com, torvalds@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: CIFS improvements/wider testing needed
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2005 13:02:39.0556 (UTC) FILETIME=[DA0D1840:01C5EE9B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As probably many others, I work in an environment where Windows servers
 (and thus CIFS filesystem) is used to store home data and backuped
shared data. With OpenOffice 2.0 now out, reading and writing Microsoft
Office documents is generally not anymore a problem except due to
current CIFS bugs.

I tried to do my part of bug hunting, carefully reporting bugs and
offering help to try to fix them (although I cannot do too hazardous
testing on my professional Laptop. See bugzilla reference below).
Unfortunately, things did not improve over the past 5 months and even
recently slightly got worse (see second bug).

Trying to push Linux in corporate environments in such condition is very
difficult because, due to those bugs, you cannot:

	1) save a new openoffice document twice,
	2) create mail folders from inside thunderbird (local mailbox shared
with windows),
	3) avoid to do FSCK after each reboot,

I've seen many changes going in CIFS git tree during this period but
only few bugs got really hunted and fixed (try to set the close option
in bugzilla at
<https://bugzilla.samba.org/buglist.cgi?query_format=specific&order=relevance+desc&bug_status=__open__&product=CifsVFS&content=>).
SMBfs do not exibit some of the bugs CIFS has but has other limitations
as well.

Could other on the LKML list try to reproduce/confirm the following bugs
with the latest snapshot:

NB : the second bug appeared with CIFS 1.39 and is not present in 2.6.14.2

BUGS :
	<https://bugzilla.samba.org/show_bug.cgi?id=2673>
	<https://bugzilla.samba.org/show_bug.cgi?id=3237>


May I suggest to fix bugs as a priority before adding new features for a
while? Or at least make sure enough testing is done to avoid regressions?



-- eric
