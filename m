Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261563AbSJALJu>; Tue, 1 Oct 2002 07:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSJALJu>; Tue, 1 Oct 2002 07:09:50 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:55785 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261564AbSJALJt>;
	Tue, 1 Oct 2002 07:09:49 -0400
Date: Tue, 1 Oct 2002 12:18:26 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "David L. DeGeorge" <dld@degeorge.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPU/cache detection wrong
Message-ID: <20021001111826.GA18583@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"David L. DeGeorge" <dld@degeorge.org>,
	linux-kernel@vger.kernel.org
References: <200209302106.10518.dld@degeorge.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209302106.10518.dld@degeorge.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 09:06:10PM -0400, David L. DeGeorge wrote:
 > I too have incorrect CPU/cache detection using  2.4.20-pre7-ac3. I seem to 
 > recall it working correctly on 2.4.19-ac1 (this was the version in which the 
 > ac did not get added by the patch). Anyway I have a tualatin PIII with a 512K 
 > L2 cache.

Some of the tualatins have an errata which makes L2 cache sizing
impossible. They actually report they have 0K L2 cache. By checking
the CPU model, we can guess we have at least 256K (which is where Linux
got that number from in your case). But this however means the 512K
models will report as 256K too.
To work around it, boot with cachesize=512 and all will be good.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
