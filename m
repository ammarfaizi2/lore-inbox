Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUGMCiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUGMCiD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 22:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUGMCiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 22:38:03 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:24705 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262138AbUGMCiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 22:38:01 -0400
Date: Mon, 12 Jul 2004 21:37:21 -0500
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: dhowells@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       slpratt@us.ibm.com
Subject: Re: [PATCH] Making i/dhash_entries cmdline work as it use to.
Message-ID: <20040713023721.GA7461@austin.ibm.com>
References: <20040712175605.GA1735@rx8.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712175605.GA1735@rx8.austin.ibm.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jose R. Santos <jrsantos@austin.ibm.com> [2004-07-12 12:56:05 -0500]:
> Also, any particular reason why MAX_SYS_HASH_TABLE_ORDER was set to 14?
> I am already seeing the need to go higher on my 64GB setup and was 
> wondering if this could be bumped up to 19.

Actualy, it doesnt look like we need MAX_SYS_HASH_TABLE_ORDER at all so
I'm resending the patch which now limits the max size of a hash table to
1/16 total memory pages.  This would keep people from doing dangerous
things when using the hash_entries.

-JRS
