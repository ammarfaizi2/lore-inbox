Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBUXIY>; Wed, 21 Feb 2001 18:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130248AbRBUXIO>; Wed, 21 Feb 2001 18:08:14 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27149 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129181AbRBUXH5>; Wed, 21 Feb 2001 18:07:57 -0500
Date: Thu, 22 Feb 2001 00:07:55 +0100
From: Martin Mares <mj@suse.cz>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
Message-ID: <20010222000755.A29061@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010221220835.A8781@atrey.karlin.mff.cuni.cz> <XFMail.20010221132959.davidel@xmailserver.org> <20010221223238.A17903@atrey.karlin.mff.cuni.cz> <971ejs$139$1@cesium.transmeta.com> <20010221233204.A26671@atrey.karlin.mff.cuni.cz> <3A94435D.59A4D729@transmeta.com> <20010221235008.A27924@atrey.karlin.mff.cuni.cz> <3A94470C.2E54EB58@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A94470C.2E54EB58@transmeta.com>; from hpa@transmeta.com on Wed, Feb 21, 2001 at 02:54:04PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> True.  Note too, though, that on a filesystem (which we are, after all,
> talking about), if you assume a large linear space you have to create a
> file, which means you need to multiply the cost of all random-access
> operations with O(log n).

One could avoid this, but it would mean designing the whole filesystem in a
completely different way -- merge all directories to a single gigantic
hash table and use (directory ID,file name) as a key, but we were originally
talking about extending ext2, so such massive changes are out of question
and your log n access argument is right.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
COBOL -- Completely Outdated, Badly Overused Language
