Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266797AbUHCSuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266797AbUHCSuk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 14:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbUHCSuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 14:50:40 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:44749 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266797AbUHCSu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 14:50:28 -0400
Message-ID: <410FDF04.9000609@sgi.com>
Date: Tue, 03 Aug 2004 13:52:52 -0500
From: Josh Aas <josha@sgi.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: why hold bkl during do_coredump?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking at not holding the bkl during do_coredump, but I can't 
figure out why its being held in the first place. I can only think of 
the need to not mess with the current memory map, but mmap_sem is 
currently held as well. Anybody know what is going on here?

-- 
Josh Aas
Silicon Graphics, Inc. (SGI)
Linux System Software
651-683-3068
