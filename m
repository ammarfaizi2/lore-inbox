Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265386AbTFFHpk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 03:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265388AbTFFHpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 03:45:40 -0400
Received: from gw.enyo.de ([212.9.189.178]:37136 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S265386AbTFFHpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 03:45:39 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.69] ext3 error: rec_len %% 4 != 0
References: <8765nva43w.fsf@deneb.enyo.de>
	<20030528012512.5d631827.akpm@digeo.com>
	<87znl45utw.fsf@deneb.enyo.de>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Fri, 06 Jun 2003 09:59:11 +0200
In-Reply-To: <87znl45utw.fsf@deneb.enyo.de> (Florian Weimer's message of
 "Fri, 30 May 2003 17:15:55 +0200")
Message-ID: <87smqn3acw.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> writes:

> I see the following messages with dmesg, but they appear to be
> non-critical:
>
> init_special_inode: bogus i_mode (67)
> init_special_inode: bogus i_mode (177766)
> init_special_inode: bogus i_mode (5)
> init_special_inode: bogus i_mode (65)
> init_special_inode: bogus i_mode (53664)
> init_special_inode: bogus i_mode (5)
>
> Are they related?  They didn't appear with ext3.

Some more data points:

  o 2.5.70 fails as well.

  o ext2 on 2.5.70, too.

  o Above errors are definitely critical. 8-(

  o It seems as if the kernel assumes that a file is a directory.  (At
    least after running 2.5.70/ext2 for a while, e2fsck had some
    problems regenerating a proper file system structure and marked a
    few files as directories.)

  o Vanilla 2.4.20 is rock solid on the same hardware (no more file
    system corruption after downgrade).
