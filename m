Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751898AbWJIWv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbWJIWv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 18:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbWJIWv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 18:51:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:726 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751898AbWJIWv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 18:51:57 -0400
Date: Mon, 9 Oct 2006 18:50:36 -0400
From: Dave Jones <davej@redhat.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Eric Sandeen <sandeen@sandeen.net>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, esandeen@redhat.com,
       Jan Kara <jack@ucw.cz>
Subject: Re: 2.6.18 ext3 panic.
Message-ID: <20061009225036.GC26728@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Eric Sandeen <sandeen@sandeen.net>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, esandeen@redhat.com,
	Jan Kara <jack@ucw.cz>
References: <20061002194711.GA1815@redhat.com> <20061003052219.GA15563@redhat.com> <4521F865.6060400@sandeen.net> <20061002231945.f2711f99.akpm@osdl.org> <452AA716.7060701@sandeen.net> <1160431165.17103.21.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160431165.17103.21.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 02:59:25PM -0700, Badari Pulavarty wrote:

 > journal_dirty_data() would do submit_bh() ONLY if its part of the older
 > transaction.
 > 
 > I need to take a closer look to understand the race.
 > 
 > BTW, is this 1k or 2k filesystem ?

(18:41:11:davej@gelk:~)$ sudo tune2fs -l /dev/md0  | grep size
Block size:               1024
Fragment size:            1024
Inode size:               128
(18:41:16:davej@gelk:~)$ 

 > How easy is to reproduce the problem ?

I can reproduce it within a few hours of stressing, but only
on that one box.  I've not figured out exactly what's so
special about it yet (though the 1k block thing may be it).
I had been thinking it was a raid0 only thing, as none of
my other boxes have that.

I'm not entirely sure how it got set up that way either.
The Fedora installer being too smart for its own good perhaps.

	Dave

-- 
http://www.codemonkey.org.uk
