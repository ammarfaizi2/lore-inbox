Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbTIPEtV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 00:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbTIPEtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 00:49:21 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:55691
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261758AbTIPEtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 00:49:20 -0400
Message-ID: <3F66960E.7010703@redhat.com>
Date: Mon, 15 Sep 2003 21:48:14 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030913 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: "Hu, Boris" <boris.hu@intel.com>, Jamie Lokier <jamie@shareable.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Split futex global spinlock futex_lock
References: <20030916010313.69E1F2C974@lists.samba.org>
In-Reply-To: <20030916010313.69E1F2C974@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> Uli, can we ask you for benchmarks with this change, too?

After these changes the code still works but I couldn't really measure
any differences to the code without the extra attributes.  This is on a
4p machine with 10 processes running in concurrently using mutexes and
condvars with 250 threads each.  This might be because either the hash
function is good or very bad (i.e., hashes all futexes in the same
bucket or far away).  I guess the extra attributes don't hurt.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

