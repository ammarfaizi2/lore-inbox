Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271848AbTGYAp6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 20:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271849AbTGYAp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 20:45:58 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:34732 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S271848AbTGYApx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 20:45:53 -0400
To: Hiroshi Miura <miura@da-cha.org>
cc: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp
Subject: Re: Japanese keyboards broken in 2.6
References: <fa.jnbj30u.1g6me0g@ifi.uio.no> <fa.d9tgtm5.1m7agi1@ifi.uio.no>
From: junkio@cox.net
Date: Thu, 24 Jul 2003 18:00:59 -0700
In-Reply-To: <fa.d9tgtm5.1m7agi1@ifi.uio.no> (Hiroshi Miura's message of
 "Thu, 24 Jul 2003 11:19:28 GMT")
Message-ID: <7vy8ynbet0.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "HM" == Hiroshi Miura <miura@da-cha.org> writes:

HM> BTW, Ogawa-san's patch is needed?

The part of his patch that enlarges the type of kbentry.kb_table
and kbentry.kb_index are needed if you ever want to use keycode
above 255. These indices are defined as unsigned char, but
NR_KEYS in 2.6 is 512 (see include/linux/keyboard.h and
include/linux/input.h) as opposed to 128.

If you are not interested in using keycode above 255 (e.g. all
you care about is keycode 183 for Japanese 86/106 keyboard),
then the patch I sent to the list should be sufficient.

