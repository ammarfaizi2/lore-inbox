Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbVKJXXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbVKJXXa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVKJXXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:23:30 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:40119 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932266AbVKJXX3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:23:29 -0500
Subject: [RFC] sys_punchhole()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org, andrea@suse.de, hugh@veritas.com
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 15:23:14 -0800
Message-Id: <1131664994.25354.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

We discussed this in madvise(REMOVE) thread - to add support 
for sys_punchhole(fd, offset, len) to complete the functionality
(in the future).

http://marc.theaimsgroup.com/?l=linux-mm&m=113036713810002&w=2

What I am wondering is, should I invest time now to do it ?
Or wait till need arises ? 

My thought line is, I would add a generic_zeroblocks_range() 
function which would zero out the given range of pages and 
flush to disk.  Use this as a default operation, if the 
filesystems doesn't provide a specific function to free up
the blocks. Would this work ?

Suggestions ?

Thanks,
Badari

