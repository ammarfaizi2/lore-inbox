Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263746AbTE3PCh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 11:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbTE3PCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 11:02:37 -0400
Received: from gw.enyo.de ([212.9.189.178]:19724 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S263737AbTE3PCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 11:02:36 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.69] ext3 error: rec_len %% 4 != 0
References: <8765nva43w.fsf@deneb.enyo.de> <20030528012512.5d631827.akpm@digeo.com>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Fri, 30 May 2003 17:15:55 +0200
Message-ID: <87znl45utw.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> Florian Weimer <fw@deneb.enyo.de> wrote:
>>
>> Sometimes, our 2.5 test machine (actually, it's a production machine,
>> please don't ask why we can't use 2.4 *sigh*) stops with an ext3 error
>> message.  We have now activated proper logging, and that's what we
>> got:
>> 
>> May 28 03:23:00 kernel: EXT3-fs error (device md0): ext3_readdir: bad entry in directory #16056745: rec_len %% 4 != 0 - offset=52, inode=431743, rec_len=37017, name_len=41 

Another error message is the following one:

EXT3-fs error (device md0): ext3_readdir: bad entry in directory #12812298: directory entry across blocks - offset=0, inode=1308, rec_len=38720, name_len=225

Hmm.

> Falling back to ext2 for a while would be interesting.

I see the following messages with dmesg, but they appear to be
non-critical:

init_special_inode: bogus i_mode (67)
init_special_inode: bogus i_mode (177766)
init_special_inode: bogus i_mode (5)
init_special_inode: bogus i_mode (65)
init_special_inode: bogus i_mode (53664)
init_special_inode: bogus i_mode (5)

Are they related?  They didn't appear with ext3.
