Return-Path: <linux-kernel-owner+w=401wt.eu-S1751712AbXAPWIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbXAPWIh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 17:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbXAPWIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 17:08:37 -0500
Received: from fe02.tochka.ru ([62.5.255.22]:45043 "EHLO umail.ru"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751701AbXAPWIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 17:08:36 -0500
From: Alex Tomas <alex@clusterfs.com>
To: Peter Staubach <staubach@redhat.com>
Cc: Eric Sandeen <sandeen@redhat.com>,
       linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>, dmonakhov@sw.ru,
       alex@clusterfs.com, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] return ENOENT from ext3_link when racing with unlink
Organization: CFS
References: <45ABC572.2070206@redhat.com> <45AD4B20.70507@redhat.com>
X-Comment-To: Peter Staubach
Date: Wed, 17 Jan 2007 01:07:59 +0300
In-Reply-To: <45AD4B20.70507@redhat.com> (Peter Staubach's message of "Tue\, 16
	Jan 2007 17\:01\:04 -0500")
Message-ID: <m33b6avd4w.fsf@bzzz.home.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Peter Staubach (PS) writes:


 PS> Just out of curosity, what keeps i_nlink from going to 0 immediately
 PS> after the new test is executed?

i_mutex in vfs_link() and vfs_unlink()

thanks, Alex
