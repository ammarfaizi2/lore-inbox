Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130749AbRAGLuk>; Sun, 7 Jan 2001 06:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130758AbRAGLub>; Sun, 7 Jan 2001 06:50:31 -0500
Received: from slamp.tomt.net ([195.139.204.145]:55183 "HELO slamp.tomt.net")
	by vger.kernel.org with SMTP id <S130749AbRAGLuM>;
	Sun, 7 Jan 2001 06:50:12 -0500
From: "Andre Tomt" <andre@tomt.net>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: "Jim Olsen" <jim@browsermedia.com>
Subject: RE: Which kernel fixes the VM issues?
Date: Sun, 7 Jan 2001 12:50:07 +0100
Message-ID: <OPECLOJPBIHLFIBNOMGBAENACHAA.andre@tomt.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <01010706312902.10913@jim.cyberjunkees.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi... I have a question or two that would help me clear up a bit
> of the fuzz
> I have relating to the VM: do_try_to_free_pages issue.

<snip>

> About once a week I get the 'VM: do_try_to_free_pages ...' error and
> eventually get a complete system lockup. And just this morning it
> locked up
> again, although this time with a 'VFS: LRU block list corrupted'
> message in
> the logs, which i'm assuming is related to the VM issue as well.

This issue is fixed in 2.2.18 AFAIK (never seen it since).

<snip>

> My question is, exactly which kernel should I use in order to rid
> my server
> of this VM issue?  I'm uncomfortable (and always have been) with
> running pre*
> kernels on production machines, so i'd like to stick with 2.2.18,
> but I would
> like to know if it truly does fix the problem(s) with the VM.  If
> I need to,
> though, I will (hesitantly) put a 2.2.19pre* kernel on the box.

Latest 2.2.19-pre has merged in Andrea's VM-global patch, which in my
experience makes life much easier on loaded servers. This patch is also
available as a 2.2.18-patch at
ftp://ftp.<countrycode>.kernel.org/pub/linux/kernel/people/andrea/patches/2.
2.18/VM-global-2.2.18pre25-7.bz2

(some mirrors lack this, so skipping the countrycode could be wise)

The latest 2.2.18 pre-version of this patch applied cleanly on my 2.2.18
final, and I've had no problems with it to date (as it's essentially the
same kernel, with just the version number bumped).

<snip>

--
Andre. Alfred?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
