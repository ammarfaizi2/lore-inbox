Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293539AbSCLAPK>; Mon, 11 Mar 2002 19:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310223AbSCLAPB>; Mon, 11 Mar 2002 19:15:01 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:36752 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S293539AbSCLAOs>; Mon, 11 Mar 2002 19:14:48 -0500
Reply-To: <robertp@ustri.com>
From: "Robert Pfister" <robertp@ustri.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: linux-2.5.4-pre1 - bitkeeper testing
Date: Mon, 11 Mar 2002 17:14:33 -0700
Message-ID: <001301c1c95a$e3adc3a0$1e00a8c0@nomaam>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <200203112134.OAA12196@tstac.esa.lanl.gov>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole writes:

>Sure, that cleans up everything and sets all the version numbers back to
;1,
>but what I was pointing out is that previously created directories and
previously
>created files retain whatever version_limit setting they were created with.
After
>running your four lines, the disk is cleaner, but you'll still get multiple
versions
>even if you don't want multiple versions for those previously created
directories
>and files.  I know, I just tried it with VMS 5.5-2.

There are two different commands in VMS:

$ set directory /limit=1 {directory name}

this sets the default behavior from that point down for new files

$ set file/limit=1  {list of files}

which sets the limit explicitly on files, and overrides the default for that
directory. You can specify [...]*.* to recurse through and set everything,
sort
of like a bash script of "$ for j in 'find .' ; do xxx $j ; done"

>But this is all rather moot,
>since the real topic at hand is not what VMS does or didn't do in the past,
but
>rather what we _might_ want certain linux filesystems to do (and not do) in
the
>future.

With VMS, the default behavior is on, and it is a pain to turn off.

Under VMS, the versioning behavior is inherited from the parent directory
that you are affecting a file in, if that directory has no attributes, it
defers to the parent. (default file protection's work in this manner as
well)

Alternatively, storing a versioning attribute at every directory, with
"blank" meaning no versioning might be a better fit.  It would certainly
make a mixed filesystem environment easier to handle.

Robb

