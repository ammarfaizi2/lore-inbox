Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBUXPo>; Wed, 21 Feb 2001 18:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130541AbRBUXPg>; Wed, 21 Feb 2001 18:15:36 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:64778 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129181AbRBUXPY>; Wed, 21 Feb 2001 18:15:24 -0500
Message-ID: <3A944C05.FC2B623A@transmeta.com>
Date: Wed, 21 Feb 2001 15:15:17 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Martin Mares <mj@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <20010221220835.A8781@atrey.karlin.mff.cuni.cz> <XFMail.20010221132959.davidel@xmailserver.org> <20010221223238.A17903@atrey.karlin.mff.cuni.cz> <971ejs$139$1@cesium.transmeta.com> <20010221233204.A26671@atrey.karlin.mff.cuni.cz> <3A94435D.59A4D729@transmeta.com> <20010221235008.A27924@atrey.karlin.mff.cuni.cz> <3A94470C.2E54EB58@transmeta.com> <20010222000755.A29061@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> 
> Hello!
> 
> > True.  Note too, though, that on a filesystem (which we are, after all,
> > talking about), if you assume a large linear space you have to create a
> > file, which means you need to multiply the cost of all random-access
> > operations with O(log n).
> 
> One could avoid this, but it would mean designing the whole filesystem in a
> completely different way -- merge all directories to a single gigantic
> hash table and use (directory ID,file name) as a key, but we were originally
> talking about extending ext2, so such massive changes are out of question
> and your log n access argument is right.
> 

It would still be tricky since you have to have actual files in the
filesystem as well.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
