Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266279AbUA3BLz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266310AbUA3BLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:11:55 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:8723 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S266279AbUA3BLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:11:53 -0500
Date: Fri, 30 Jan 2004 01:30:42 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Frodo Looijaard <frodol@dds.nl>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       linux-7110-psion@lists.sourceforge.net
Subject: Re: PATCH to access old-style FAT fs
Message-ID: <20040130013042.A19516@pclin040.win.tue.nl>
References: <20040126173949.GA788@frodo.local> <bv3qb3$4lh$1@terminus.zytor.com> <87n0898sah.fsf@devron.myhome.or.jp> <4016B316.4060304@zytor.com> <87ad4987ti.fsf@devron.myhome.or.jp> <20040128115655.GA696@arda.frodo.local> <87y8rr7s5b.fsf@devron.myhome.or.jp> <20040128202443.GA9246@frodo.local> <87bron7ppd.fsf@devron.myhome.or.jp> <20040129223944.GA673@frodo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040129223944.GA673@frodo.local>; from frodol@dds.nl on Thu, Jan 29, 2004 at 11:39:44PM +0100
X-Spam-DCC: MessageCare: kweetal.tue.nl 1108; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 11:39:44PM +0100, Frodo Looijaard wrote:

> I have attached a newer, better behaving version of my patch:
>   * Implements new mount option oldfat for FAT-derived filesystems.
>   * Stops scanning dirs when DIR_Name[0] = 0 when oldfat is set
>   * Writes a 0 to the next entry DIR_Name[0] when overwriting an entry
>     which has DIR_Name[0] = 0 when oldfat is set

Just amused myself checking all data I can find about such stuff.
And read the replies by Hirofumi and hpa.
I completely agree with them.

The DOS situation is not so much that 0 is an end-of-dir marker.
It marks that this entry, and all following entries, has never
been used.

For the time being there is no justification for "oldfat".
The only place where this behaviour has been reported (not only by you,
I saw several references) is on Psion PDAs. So "psion" would be a more
obvious name, if a mount option is needed.

And maybe no mount option is needed.
Your 2nd and 3rd points can be done always, I think, unless our FAT code
should mimic the DOS FAT behaviour (on non-DOS filesystems).

Andries

