Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWCSBHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWCSBHl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 20:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWCSBHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 20:07:41 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:46529 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751187AbWCSBHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 20:07:40 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: /dev/stderr gets unlinked 8]
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Denis Vlasenko <vda@ilport.com.ua>, Andreas Schwab <schwab@suse.de>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       christiand59@web.de
Reply-To: 7eggert@gmx.de
Date: Sun, 19 Mar 2006 02:07:19 +0100
References: <5QeND-31x-7@gated-at.bofh.it> <5QE55-6Td-9@gated-at.bofh.it> <5R778-8fs-29@gated-at.bofh.it> <5RgN2-5fi-3@gated-at.bofh.it> <5RohF-7Oe-3@gated-at.bofh.it> <5Rpnz-ZJ-39@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1FKmO8-000303-Ve@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
> On Fri, 17 Mar 2006, Jan Engelhardt wrote:

>> If not, you could write an LSM that prohibits unlinking /dev/stderr.

> That symlink isn't even used -- at least by any sane program!
> I don't have a clue why these things were created and what they
> were for. The objects stdin, stdout, and stderr, are 'C' runtime
> library pointers to opaque types associated with the file descriptors,
> STDIN_FILENO, STDOUT_FILENO, and STDERR_FILENO. The presence of
> these bogus sym-links in /dev represent some kind of obfuscation
> and have no value except to confuse (or identify a RedHat distribution).

Think about portable shell scripts. I remember /dev/std* longer than /proc.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
