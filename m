Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423707AbWJaRXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423707AbWJaRXW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423703AbWJaRXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:23:22 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:59396 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1423700AbWJaRXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:23:00 -0500
Date: Tue, 31 Oct 2006 18:22:58 +0100
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Reading a bunch of file as fast a possible
Message-ID: <20061031172258.GB8230@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After searching for kinda-keywords in a locked-in-memory index, I get
a list of 50-100 files out of several hundred thousands I want to read
as fast as possible.  I can ensure that the directory structure in hot
in the dcache by re-reading it from time to time, but there isn't
enough memory to lock the documents there.  So I'd like to read 50-100
files for which I have the sizes (I put them in the index) and memory
space as fast as possible (less than 0.1s would be great) from
cold-ish cache.

The best way is I think to find a way to give all the requests to the
system and have it sort them optimally at the elevator level.  But how
can I do that?  Can aio do it, or something else?

  OG.

