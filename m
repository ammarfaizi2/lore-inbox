Return-Path: <linux-kernel-owner+w=401wt.eu-S1161095AbXALV0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbXALV0r (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161085AbXALV0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:26:47 -0500
Received: from fe02.tochka.ru ([62.5.255.22]:46333 "EHLO umail.ru"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161082AbXALV0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:26:45 -0500
From: Alex Tomas <alex@clusterfs.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Alex Tomas <alex@clusterfs.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] [RFC] remove ext3 inode from orphan list when link and unlink race
Organization: CFS
References: <45A7F384.3050303@redhat.com> <m34pqw0xii.fsf@bzzz.home.net>
	<45A7FA3C.8030209@redhat.com>
X-Comment-To: Eric Sandeen
Date: Sat, 13 Jan 2007 00:25:28 +0300
In-Reply-To: <45A7FA3C.8030209@redhat.com> (Eric Sandeen's message of "Fri\, 12
	Jan 2007 15\:14\:36 -0600")
Message-ID: <m3lkk8ym2f.fsf@bzzz.home.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Eric Sandeen (ES) writes:

 ES> so I think it's possible that link can sneak in there & find it after
 ES> the mutex is dropped...?  Is this ok? :)  It's certainly -happening-
 ES> anyway....

yes, but it shouldn't allow to re-link such inode back, IMHO.
a filesystem may start some non-revertable activity in its
unlink method.

thanks, Alex
