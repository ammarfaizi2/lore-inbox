Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUITJqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUITJqG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 05:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266187AbUITJqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 05:46:06 -0400
Received: from cantor.suse.de ([195.135.220.2]:33190 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266186AbUITJqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 05:46:03 -0400
Date: Mon, 20 Sep 2004 11:46:02 +0200
From: Olaf Hering <olh@suse.de>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040920094602.GA24466@suse.de>
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Sep 20, Andries.Brouwer@cwi.nl wrote:

> then /etc/mtab can die. Comments? Better solutions?

Andries, /etc/mtab is obsolete since the day when /proc/self/mounts was
introduced. So, kill it today from your mount binary! TODAY. ...

Then discuss what is still missing from /proc/self/mounts:

- the 'user' option for umount must be handled in some way
- loop mounts do not map to the real filename, users cant open the
  device node to run losetup on it. I think it will also get relative
  path names.
- fix all broken apps that still rely on mtab. like GNU df(1)

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
