Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVHLQR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVHLQR6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 12:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVHLQR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 12:17:58 -0400
Received: from hastings.mumak.ee ([194.204.22.4]:23733 "EHLO hastings.mumak.ee")
	by vger.kernel.org with ESMTP id S1751216AbVHLQR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 12:17:57 -0400
Subject: Re: BUG: reiserfs+acl+quota deadlock
From: Tarmo =?ISO-8859-1?Q?T=E4nav?= <tarmo@itech.ee>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, mason@suse.com, jeffm@suse.com,
       grev@namesys.com
In-Reply-To: <42FCB873.8070900@namesys.com>
References: <1123643111.27819.23.camel@localhost>
	 <20050810130009.GE22112@atrey.karlin.mff.cuni.cz>
	 <1123684298.14562.4.camel@localhost>
	 <20050810144024.GA18584@atrey.karlin.mff.cuni.cz>
	 <42FCB873.8070900@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 12 Aug 2005 19:17:50 +0300
Message-Id: <1123863470.14337.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On R, 2005-08-12 at 18:55 +0400, Vladimir V. Saveliev wrote:
> 
> It looks like the problem is that reiserfs_new_inode can be called either having xattrs locked or not.
> It does unlocking/locking xattrs on error handling path, but has no idea about whether
> xattrs are locked of not.
> The attached patch seems to fix the problem.
> I am not sure whether it is correct way to fix this problem, though.
> 
> Tarmo, please check if this patch works for you.


Sorry, I made a mistake when I first tested the patch, got some
kernel images mixed up, it does fix the problem, thank you.



-- 
Tarmo Tänav <tarmo@itech.ee>

