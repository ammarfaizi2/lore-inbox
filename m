Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbREOUII>; Tue, 15 May 2001 16:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbREOUHu>; Tue, 15 May 2001 16:07:50 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:4359 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261426AbREOUHp>; Tue, 15 May 2001 16:07:45 -0400
Message-ID: <3B018C83.CC3228AC@transmeta.com>
Date: Tue, 15 May 2001 13:07:31 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Getting FS access events
In-Reply-To: <Pine.GSO.4.21.0105151602430.21081-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On 15 May 2001, H. Peter Anvin wrote:
> 
> > isofs wouldn't be too bad as long as struct mapping:struct inode is a
> > many-to-one mapping.
> 
> Erm... What's wrong with inode->u.isofs_i.my_very_own_address_space ?
> 

None whatsoever.  The one thing that matters is that noone starts making
the assumption that mapping->host->i_mapping == mapping.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
