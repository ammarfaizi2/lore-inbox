Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTEHHyp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 03:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbTEHHyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 03:54:45 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:61838 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261193AbTEHHyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 03:54:44 -0400
Date: Thu, 8 May 2003 10:07:12 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'jw schultz'" <jw@pegasys.ws>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Swap Compression
Message-ID: <20030508080712.GA1469@wohnheim.fh-wedel.de>
References: <A46BBDB345A7D5118EC90002A5072C780C8FE1E2@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780C8FE1E2@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003 20:17:32 -0700, Perez-Gonzalez, Inaky wrote:
> 
> This reminds me of some howto I saw somewhere of someway to
> use the MTD drivers to access the unused video RAM and turn
> it into swap (maybe with blkmtd?) ... probably it can be done
> with that too.

Jupp, if you know the physical address range of the RAM, it's a piece
of cake. Except that the slram option parsing is not user-friendly,
with me being an examplary user.

For memory above 4GB, things are harder. Basically you'd have to write
a new mtd driver that copies some of the highmem code. Maybe a day or
two plus testing.

> I'd really love it ... I don't know if I can blame it on highmem
> or not, but since I enabled it, my system 'feels' slower.

Go ahead and try it. If it 'feels' faster, it should be possible to
benchmark your feeling into some numbers.

Jörn

-- 
Victory in war is not repetitious.
-- Sun Tzu
