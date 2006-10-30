Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161201AbWJ3QAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161201AbWJ3QAw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 11:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161202AbWJ3QAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 11:00:51 -0500
Received: from raven.upol.cz ([158.194.120.4]:6379 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1161201AbWJ3QAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 11:00:51 -0500
To: Valdis.Kletnieks@vt.edu, Jan Beulich <jbeulich@novell.com>,
       Oleg Verych <olecom@flower.upol.cz>, dsd@gentoo.org, kernel@gentoo.org,
       draconx@gmail.com, jpdenheijer@gmail.com, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
X-Posted-To: gmane.linux.kernel
Subject: Re: [PATCH -mm] replacement for broken kbuild-dont-put-temp-files-in-the-source-tree.patch
References: <20061028230730.GA28966@quickstop.soohrt.org> <200610281907.20673.ak@suse.de> <20061029120858.GB3491@quickstop.soohrt.org> <200610290816.55886.ak@suse.de> <slrnek9qv0.2vm.olecom@flower.upol.cz> <20061029225234.GA31648@uranus.ravnborg.org> <4545C2D8.76E4.0078.0@novell.com> <slrnekbv60.2vm.olecom@flower.upol.cz> <slrnekc3q8.2vm.olecom@flower.upol.cz> <200610301522.k9UFMXmM004701@turing-police.cc.vt.edu>
Organization: Palacky University in Olomouc, experimental physics department.
Date: Mon, 30 Oct 2006 16:06:17 +0000
Message-ID: <slrnekc8np.2vm.olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-10-30, Valdis.Kletnieks wrote:
>
> Hmm.. and even the 'ln' worked even when z9 was chmod 0. ;)
(WTF! I'm no wonder any more, why all that selinux was brought ;)

Well, i've said already about roots in post above.
This fix is for needless mktemp and old binutils.

Fix for roots:
,--
|if [ `id -u` == "0" ]; then echo "Root landed !!!"; ! true; fi
`--
More polite fools-protection, with guaranteed permission from the user:
,--
|if [ `id -u` == "0" ]; then useradd bkernel && su bkernel fi;
`--
____
