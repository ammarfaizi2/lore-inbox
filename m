Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266225AbTLIKKE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 05:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266226AbTLIKKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 05:10:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4777 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266225AbTLIKKA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 05:10:00 -0500
Date: Tue, 9 Dec 2003 10:09:59 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Domen Puncer <domen@coderock.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.23, 2.6.0-test11] fix d_type in readdir in isofs
Message-ID: <20031209100959.GB4176@parcelfarce.linux.theplanet.co.uk>
References: <200312091047.33015.domen@coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312091047.33015.domen@coderock.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 10:47:32AM +0100, Domen Puncer wrote:
> Hi!
> 
> Played with scandir, and noticed iso9660's files d_type is always 0,
> so here's a fix.

No, it isn't.  DT_UNKNOWN is "I don't know; make no assumptions".
DT_REG is "regular file".  Returning it when object in question is
e.g. a symlink is wrong.
