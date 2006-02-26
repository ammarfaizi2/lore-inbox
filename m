Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWBZTWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWBZTWD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 14:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWBZTWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 14:22:01 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:57581 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932215AbWBZTV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 14:21:57 -0500
Subject: Re: [PATCH] silence gcc warning about possibly uninitialized use
	of variable in scsi_scan
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Eric Youngdale <eric@andante.org>,
       linux-scsi@vger.kernel.org
In-Reply-To: <9a8748490602261101q39f4cf8eqabe0143921389ce6@mail.gmail.com>
References: <200602261639.15657.jesper.juhl@gmail.com>
	 <1140978084.3692.6.camel@mulgrave.il.steeleye.com>
	 <9a8748490602261023j46eb39f2peaa080d737fee5e1@mail.gmail.com>
	 <1140980377.3692.9.camel@mulgrave.il.steeleye.com>
	 <9a8748490602261101q39f4cf8eqabe0143921389ce6@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 13:21:54 -0600
Message-Id: <1140981714.3692.12.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 20:01 +0100, Jesper Juhl wrote:
> Hmm, it's quite reproducible and the gcc 3.4.5 I have here is not
> patched by the distribution (Slackware). If you want I can send you
> the .config that results in the warning..

I really don't think it's a config issue.  scsi_probe_lun() is always
compiled in if CONFIG_SCSI is set.  I think you have a compiler problem.

James


