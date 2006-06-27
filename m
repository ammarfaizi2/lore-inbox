Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161151AbWF0QM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbWF0QM7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161150AbWF0QM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:12:59 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:45510 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1161143AbWF0QM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:12:58 -0400
Subject: Re: Areca driver recap + status
From: James Bottomley <James.Bottomley@SteelEye.com>
To: erich <erich@areca.com.tw>
Cc: Andrew Morton <akpm@osdl.org>, "\"Robert Mueller\"" <robm@fastmail.fm>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       dax@gurulabs.com, brong@fastmail.fm, hch@infradead.org,
       rdunlap@xenotime.net
In-Reply-To: <003701c699ce$c126b550$b100a8c0@erich2003>
References: <09be01c695b3$2ed8c2c0$c100a8c0@robm>
	 <20060621222826.ff080422.akpm@osdl.org>
	 <1151333338.2673.4.camel@mulgrave.il.steeleye.com>
	 <003701c699ce$c126b550$b100a8c0@erich2003>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 11:12:39 -0500
Message-Id: <1151424759.3340.39.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 17:47 +0800, erich wrote:
> Does arcmsr still has more than one value per file issue on it?
> Maybe I am miss-understand the means of one value per file.

The idea is that sysfs files are named according to their contents, so
you should be able to cat the file to get the value.  The issue, which
is very simple to resolve with your driver, is that all the current
values are preceded by strings, so they have to be parsed to get the
value instead of just being directly read (I think this is a residue of
the fact that it's a straight conversion of a single proc file).

James


