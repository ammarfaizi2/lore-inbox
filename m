Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261734AbTCaRo1>; Mon, 31 Mar 2003 12:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261738AbTCaRo1>; Mon, 31 Mar 2003 12:44:27 -0500
Received: from to-telus.redhat.com ([207.219.125.105]:17918 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261734AbTCaRo1>; Mon, 31 Mar 2003 12:44:27 -0500
Date: Mon, 31 Mar 2003 12:55:48 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmap-related questions
Message-ID: <20030331125548.D20730@redhat.com>
References: <20030331144110.55232.qmail@web20003.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030331144110.55232.qmail@web20003.mail.yahoo.com>; from theonetruekenny@yahoo.com on Mon, Mar 31, 2003 at 06:41:10AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 06:41:10AM -0800, Kenny Simpson wrote:
> I tested that fsync() does not seem to sync pages that
> were mapped with mmap.  Is there some way to sync all
> data associated with the file?  Is there a way which
> is also portable to Solaris 2.6?

No.  You must use msync().  Note that fsync() after munmap() will flush the 
pages to disk under Linux.

> BTW: I'm using 2.4.7 (RH enterprise)

2.4.7 is way out of date and should be updated for the numerous bugfixes and 
security errata.

		-ben
