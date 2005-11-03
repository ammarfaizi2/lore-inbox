Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbVKCADZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbVKCADZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 19:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbVKCADY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 19:03:24 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:58343 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1030190AbVKCADY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 19:03:24 -0500
Date: Thu, 3 Nov 2005 01:03:17 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS information leak during crash
Message-ID: <20051103000317.GE6759@fi.muni.cz>
References: <20051102212722.GC6759@fi.muni.cz> <20051103101107.O6239737@wobbly.melbourne.sgi.com> <20051102233629.GD6759@fi.muni.cz> <20051103104956.B6081538@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103104956.B6081538@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:
: XFS behaves as most filesystems do and
: will write over the top of existing data.

	OK, thanks for the clarification.

: XFS also rewrites files in-place.  You will never get someone else's
: current data (that would be metadata corruption...),

	Of course.

: it would only
: ever be uninitialised, previously-free space.

	Yes, but an old data from previously deleted files
(sendmail's temporary files, vim save files, etc) may contain
a sensitive information.

-Y.

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> Specs are a basis for _talking_about_ things. But they are _not_ a basis <
> for implementing software.                              --Linus Torvalds <
