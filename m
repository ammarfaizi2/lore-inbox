Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTDGG1P (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 02:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263279AbTDGG1P (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 02:27:15 -0400
Received: from h24-81-49-25.ca.shawcable.net ([24.81.49.25]:6570 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263275AbTDGG1N (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 02:27:13 -0400
Date: Sun, 6 Apr 2003 23:38:40 -0700
From: Jack Bowling <jbinpg@shaw.ca>
To: linux-kernel@vger.kernel.org
Subject: ac97_codec.c bombing in 2.4.21-pre7
Message-ID: <20030407063840.GA24256@nonesuch>
Reply-To: Jack Bowling <jbinpg@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.21-pre6 patch installed and compiled perfectly on my RH 8 box.
Trying to build the emu10k1 module, 2.4.21-pre7 patch with same .config and same
compiler bombs. For giggles, I tried the compile command string with and
without "env LANG=C" to nullify any unicode issues but it made no difference.

Here is just the start of the error output:

ac97_codec.c:131: `AC97_NO_PCM_VOLUME' undeclared here (not in a
function)
ac97_codec.c:131: initializer element is not constant
ac97_codec.c:131: (near initialization for `ac97_codec_ids[12].flags')
ac97_codec.c:131: initializer element is not constant
ac97_codec.c:131: (near initialization for `ac97_codec_ids[12]')
ac97_codec.c:132: `AC97_NO_PCM_VOLUME' undeclared here (not in a
function)
ac97_codec.c:132: initializer element is not constant
ac97_codec.c:132: (near initialization for `ac97_codec_ids[13].flags')
ac97_codec.c:132: initializer element is not constant
ac97_codec.c:132: (near initialization for `ac97_codec_ids[13]')
ac97_codec.c:133: `AC97_NO_PCM_VOLUME' undeclared here (not in a
function)
ac97_codec.c:133: initializer element is not constant
ac97_codec.c:133: (near initialization for `ac97_codec_ids[14].flags')
ac97_codec.c:133: initializer element is not constant
ac97_codec.c:133: (near initialization for `ac97_codec_ids[14]')
ac97_codec.c:134: initializer element is not constant
ac97_codec.c:134: (near initialization for `ac97_codec_ids[15]')
ac97_codec.c:135: initializer element is not constant
ac97_codec.c:135: (near initialization for `ac97_codec_ids[16]')
ac97_codec.c:136: initializer element is not constant
ac97_codec.c:136: (near initialization for `ac97_codec_ids[17]')
ac97_codec.c:137: initializer element is not constant
ac97_codec.c:137: (near initialization for `ac97_codec_ids[18]')
ac97_codec.c:138: initializer element is not constant
ac97_codec.c:138: (near initialization for `ac97_codec_ids[19]')
ac97_codec.c:139: initializer element is not constant
ac97_codec.c:139: (near initialization for `ac97_codec_ids[20]')
ac97_codec.c:140: initializer element is not constant
ac97_codec.c:140: (near initialization for `ac97_codec_ids[21]')
ac97_codec.c:141: initializer element is not constant
ac97_codec.c:141: (near initialization for `ac97_codec_ids[22]')
ac97_codec.c:142: initializer element is not constant
ac97_codec.c:142: (near initialization for `ac97_codec_ids[23]')
ac97_codec.c:143: initializer element is not constant
ac97_codec.c:143: (near initialization for `ac97_codec_ids[24]')
ac97_codec.c:144: `AC97_DELUDED_MODEM' undeclared here (not in a
function)
ac97_codec.c:144: initializer element is not constant
ac97_codec.c:144: (near initialization for `ac97_codec_ids[25].flags')
ac97_codec.c:144: initializer element is not constant
ac97_codec.c:144: (near initialization for `ac97_codec_ids[25]')
ac97_codec.c:145: initializer element is not constant
ac97_codec.c:145: (near initialization for `ac97_codec_ids[26]')
ac97_codec.c:146: initializer element is not constant
ac97_codec.c:146: (near initialization for `ac97_codec_ids[27]')
...

I believe these were Alan's changes according to the changelog.

-- 
Jack Bowling
mailto: jbinpg@shaw.ca
