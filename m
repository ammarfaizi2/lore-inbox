Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265792AbUGEGIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbUGEGIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 02:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbUGEGIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 02:08:48 -0400
Received: from smtp07.web.de ([217.72.192.225]:59801 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S265792AbUGEGIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 02:08:46 -0400
Subject: Re: [BUG] FAT broken in 2.6.7-bk15
From: Ali Akcaagac <aliakc@web.de>
To: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp
Content-Type: text/plain
Date: Mon, 05 Jul 2004 08:08:55 +0200
Message-Id: <1089007735.675.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But you didn't install these. So fatfs couldn't do what you specified,
> then fatfs logged it and returns error.
> 
> Looks like you want to the following config.
> 
> CONFIG_FAT_DEFAULT_CODEPAGE=850
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-15"

Right I figured this one out myself already (see the other mail to you earlier this morning). I only questionize whether having to do this "manually" is such a good idea and if it doesn't lead to misunderstanding (better explaination in my other mail too).

I recommend to have something like this:

check whether some default NLS and character encoding has been selected in default NLS option.

- If not select 437 and iso8859-1 automatically for msdos and also 'enable' these automatically in the default NLS setup.

- If something has been selected in the default NLS already then popup a submenu which only shows those that you already have selected in the default NLS setup. So you can chose between those you already have selected.

- If only utf-8 has been selected in default NLS previously then throw out a warning or something.

At least in any cases make sure that you MUST select something to get msdos and fat support compiled and working correctly so that cases like mine NEVER happens.


