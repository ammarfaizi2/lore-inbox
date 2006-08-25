Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWHYJpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWHYJpZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 05:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWHYJpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 05:45:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23985 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932363AbWHYJpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 05:45:24 -0400
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
From: David Woodhouse <dwmw2@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0608251110060.1212@yvahk01.tjqt.qr>
References: <1156429585.3012.58.camel@pmac.infradead.org>
	 <1156433068.3012.115.camel@pmac.infradead.org>
	 <Pine.LNX.4.61.0608241840440.16422@yvahk01.tjqt.qr>
	 <1156439110.3012.147.camel@pmac.infradead.org>
	 <Pine.LNX.4.61.0608250759190.7912@yvahk01.tjqt.qr>
	 <1156496116.2984.14.camel@pmac.infradead.org>
	 <Pine.LNX.4.61.0608251110060.1212@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 10:45:22 +0100
Message-Id: <1156499122.2984.36.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 11:11 +0200, Jan Engelhardt wrote:
> That's what I meant. Assume I explicitly built read.o foo.o and bar.o.
> If I then run the regular make, it will rerun gcc for read.c foo.c and 
> bar.c rather than using the already-created .o files for linking. 

Yes. Just as if I run 'make fs/ntfs/inode.o' and then build my kernel,
my build of fs/ntfs/inode.o isn't used -- because I don't have
CONFIG_NTFS set. 

You built something manually that wasn't needed, and then it wasn't
used. Is there a problem here?

-- 
dwmw2

