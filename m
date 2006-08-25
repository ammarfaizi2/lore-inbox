Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWHYJh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWHYJh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 05:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWHYJh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 05:37:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37006 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932358AbWHYJh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 05:37:27 -0400
Subject: Re: [PATCH 2/4] Core support for --combine -fwhole-program
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060824213302.GS19810@stusta.de>
References: <1156429585.3012.58.camel@pmac.infradead.org>
	 <1156433167.3012.119.camel@pmac.infradead.org>
	 <20060824213302.GS19810@stusta.de>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 10:37:23 +0100
Message-Id: <1156498643.2984.28.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 23:33 +0200, Adrian Bunk wrote:
> If a "build everything except for assembler files at once" approach is 
> possible, it should be possible to revert this and get even further 
> savings.

Only if we build _everything_ at once, which may take an insane amount
of RAM. Doing it a directory at a time makes a certain amount of sense,
and tends to combine the most incestuous code -- although maybe
combinations like building arch/$ARCH/kernel/ with kernel/ (and likewise
mm) could be an interesting experiment.

I suspected that most of the 'further savings' to which you refer above
could be achieved more easily with -ffunction-sections -fdata-sections
--gc-sections

-- 
dwmw2

