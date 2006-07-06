Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWGFMnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWGFMnj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 08:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbWGFMnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 08:43:39 -0400
Received: from pat.uio.no ([129.240.10.4]:58327 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965192AbWGFMnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 08:43:39 -0400
Subject: Re: ext4 features
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44AC7647.2080005@tmr.com>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com>
	 <20060705125956.GA529@fieldses.org> <44AC2B56.8010703@tmr.com>
	 <20060705214133.GA28487@fieldses.org>  <44AC7647.2080005@tmr.com>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 08:43:15 -0400
Message-Id: <1152189796.5689.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.119, required 12,
	autolearn=disabled, AWL 1.69, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-05 at 22:32 -0400, Bill Davidsen wrote:

> But with timestamps I need remember only one number, the time of my last 
> backup. Skipping over the question of "who's idea of time" inherent in 
> network filesystems. I compare all ctimes with the time of the last 
> backup and do incremental on the newer ones. If we use versioning I have 
> to remember the version for each file! In practice I really question if 
> the benefit justified keeping all that metadata between backups. And if 
> I delete a file and create another by the same name, what is it's version?

You are completely missing the point. Our background is that all NFS
clients are required to use the mtime and ctime timestamps in order to
figure out if their cached data is valid. They need to do this extremely
frequently (in fact, every time you open() the file).

Nobody gives a rats arse about backups: those are infrequent and
can/should use more sophisticated techniques such as checksumming.

Cheers,
  Trond

