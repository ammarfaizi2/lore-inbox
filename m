Return-Path: <linux-kernel-owner+w=401wt.eu-S932330AbWLLSoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWLLSoV (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWLLSoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:44:21 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:29330 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330AbWLLSoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:44:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lHsDQsxTnVxUpAeIkyqsBFL3WGIRPSQH5t0Xq7KQzFGfb5Xct/JlZtvJTLt6C82hPl9GYLWXAldRc81t05u8fk1DBXYNHa6Y5SydsHK3XdkNuP3lBmHRC1H79Wq3j1EB1RqcyYRA1xXk3TnSQKS9tkO/3P97Gu2/Q8jqvETpBvg=
Message-ID: <bc36a6210612121044vf259b34u4ec3cac4df56e43c@mail.gmail.com>
Date: Tue, 12 Dec 2006 11:44:18 -0700
From: "Andrew Robinson" <andrew.rw.robinson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ReiserFS corruption with 2.6.19 (Was 2.6.19 is not stable with SATA and should not be used by any meansis not stable with SATA and should not be used by any means)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I'm having a really bad day (or week) and I want to apologize
for the rantish email. I just went back into the configuration for the
new kernel, and I was wrong about the experimental state of the SATA,
but it appears the PATA state is experimental instead.

Now I am confused on what may be the cause of the corruption. Could it
have been just a ReiserFS problem (I will be using Ext3 or JSF on my
next rebuild I think after reading some reviews on the ReiserFS and
this recent experience).

When I said hibernate, I did mention it was to disk, not to ram. I
woke my computer up from work remotely using wakeonlan. When the
computer was responsive, I started getting I/O errors and when I saw
my kernel log I saw file corruption problems with my "/dev/sda2"
device (which is my root file system and is one of two, the other is
the swap partition)

I'm not sure if it could be a SATA_NV driver problem, a hibernate
problem, or a ReiserFS problem or a combination of the above. For
hibernation, I had the resume2 kernel boot option set as /dev/sda1 (my
swap partition). I do not have suspend2 installed though, I have been
relying on its fallback settings to ususpend or sysfs (not sure which
one is actually executed).

My wor laptop (IBM/Lenova T43) has the same setup on 2.6.18.3 and I
have be suspending to RAM and to disk without issue for a while now.
The modules in use by my laptop:
libata                 89556  2 ata_piix,ahci
scsi_mod              124296  5 sg,sr_mod,sd_mod,ahci,libata

Here is my relavant hardware and software once again:
EPoX 9npa + Ultra mother board (NVIDIA nForce4 + Ultra chipset)
SATA 2 Samsung drive
AMD 64 Dual Core X2 (I am on the i386 platform though as too many
programs were too much effort to configure on amd64 to bother with for
the little performance gain I'd get with what I normally do)

Kernel 2.6.19
Hibernate 1.94-2
ReiserFS
Debian Etch

What do you kernel experts think that could have been the issue (some
combination of 2.6.19, sata_nv, hibernate, ReiserFS)? After this I am
reluctant to go back to the *19 instead of *18 kernel.

BTW - the reason I hibernate is because I sometimes dual boot into
windows (for games that don't play well on cedega) and I prefer to not
use the electricity from running the computer 24x7 when I don't need
to, but I like to have my desktop state remain constant as I often
have multiple programs open for development.

Sorry for the first email format. Thanks again for any help on the issue
