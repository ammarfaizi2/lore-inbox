Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbVKGKFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVKGKFg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbVKGKFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:05:36 -0500
Received: from ns2.suse.de ([195.135.220.15]:18602 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932475AbVKGKFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:05:36 -0500
Date: Mon, 7 Nov 2005 11:06:12 +0100
From: jblunck@suse.de
To: Rob Landley <rob@landley.net>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
Message-ID: <20051107100612.GA7932@hasse.suse.de>
References: <20051104113851.GA4770@hasse.suse.de> <20051104115101.GH7992@ftp.linux.org.uk> <200511041055.33882.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200511041055.33882.rob@landley.net>
"From: jblunck@suse.de"
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, Rob Landley wrote:

> 
> That said, I'm pretty sure it's the old libc behavior that's defective.  If a 

So, what should the libc do? Reread the whole directory if it is changed? It
would be a nice DoS attack to just create and delete files and prevent others
from reading that directory.

IMHO it is the job of the filesystem implementation to allow correct SuSV3
specified directory reading.

Regards,
	Jan Blunck

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
