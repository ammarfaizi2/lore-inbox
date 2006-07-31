Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWGaPZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWGaPZN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 11:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWGaPZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 11:25:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:55155 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030185AbWGaPZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 11:25:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Clg8e3hOmOpjN0PRbqV/oxpMpCoLcNV0C9nWMHOSW8JUQWroORHDRn+4oaY0p2U/eiK7BXKJWd6V7XDqEpVYK5tWjfbnJ2W7Br0P75rM8615cCdyErLn4RVcQ+HE0TnKvXd6UJ5JXjl8IjjbW9oKOE5FyDw8G0I7Ux3UdLLgako=
Message-ID: <1d950a40607310825n334789e8ma98eb29612c8fbf0@mail.gmail.com>
Date: Mon, 31 Jul 2006 17:25:10 +0200
From: "erlk ozlr" <erlk.ozlr@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: OSS/MAD16 not available to compilation of kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm using linux 2.6.17 and I want to compile the mad16 driver but "at
least" CONFIG_SOUND_MAD16 is not present in "<source
root>/sound/oss/Kconfig" which makes it unchoosable in the `make
<something>config`, but there is still presence in the
"/sound/oss/Makefile".
I said "at least" because adding "CONFIG_SOUND_MAD16=m" in the
".config" file doesn't help : when I do `make modules_prepare`, it
removes the line, and I add it again then do `make modules
SUBDIRS=sound/oss` (well, I don't want to compile the whole kernel and
modules, I only lack mad16 ; I'm telling it because it perhaps has
consequences), it produces warnings (I don't know if it's the same
problem) but I have a mad16.ko.
Here is some log (maybe it isn't interesting) : """
  Building modules, stage 2.
  MODPOST
WARNING: sound/oss/cs4232.o - Section mismatch: reference to
.init.text: from .text between 'cs4232_pnp_probe' (at offset 0x5d) and
'unload_cs4232'
WARNING: sound/oss/mad16.o - Section mismatch: reference to
.init.data:mpu_io from .text after 'init_module' (at offset 0x15b)
"""
then follows many lines like this last one (the offset and the
"reference to" do change)

I can't tell you yet if the mad16.ko works because I'm lacking some
cross-kernel-compilation knowledge too : it says "invalid module
format", I checked the gcc version, building against the same x.y.z
version kernel source (please notice the subtly silent newbie-question
:-) ), and both computers are i386 (as says `file mad16.ko`).

ah, last thing, the report-bug-howto tells me to give keywords, so
here some :-) : modules, sound, obsolete, oss, mad16

thanks if you can fix or explain it :-)
