Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbTI3Vsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTI3Vsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:48:45 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:38814
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261774AbTI3Vsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:48:43 -0400
Message-ID: <3F79FA20.4010706@redhat.com>
Date: Tue, 30 Sep 2003 14:48:16 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20030924 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Jamie Lokier <jamie@shareable.org>,
       linux mailing-list <linux-kernel@vger.kernel.org>,
       "Hu, Boris" <boris.hu@intel.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.0-test6 oops futex"
References: <Pine.LNX.4.44.0309302141220.4388-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0309302141220.4388-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

> (Oh, while you're there, be nice to fix nr_requeue 0.)

Not necessary.  FUTEX_REQUEUE with nr_requeue == 0 is the same as
FUTEX_WAKE.  When we wrote the code we decided that it is better to
optimize the requeue as much as possible and leave worrying about
invalid parameters to the user.  Not that the code will not cause any
crashes or so.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

